use std::collections::{HashMap, HashSet};
use std::rc::Rc;
use std::cell::RefCell;

struct LinkedListNode {
    count: i32,
    keys: HashSet<String>,
    prev: Option<Rc<RefCell<LinkedListNode>>>,
    next: Option<Rc<RefCell<LinkedListNode>>>,
}

impl LinkedListNode {
    fn new(count: i32) -> Rc<RefCell<Self>> {
        Rc::new(RefCell::new(LinkedListNode {
            count,
            keys: HashSet::new(),
            prev: None,
            next: None,
        }))
    }
}

struct AllOne {
    key_to_count: HashMap<String, i32>,
    count_to_node: HashMap<i32, Rc<RefCell<LinkedListNode>>>,
    head: Rc<RefCell<LinkedListNode>>, // Dummy head
    tail: Rc<RefCell<LinkedListNode>>, // Dummy tail
}

impl AllOne {
    fn new() -> Self {
        let head = LinkedListNode::new(0); // Dummy node with count 0
        let tail = LinkedListNode::new(0); // Dummy node with count 0

        head.borrow_mut().next = Some(Rc::clone(&tail));
        tail.borrow_mut().prev = Some(Rc::clone(&head));

        AllOne {
            key_to_count: HashMap::new(),
            count_to_node: HashMap::new(),
            head,
            tail,
        }
    }

    // Helper to insert a new_node after an existing prev_node
    fn insert_node_after(&mut self, prev_node_rc: Rc<RefCell<LinkedListNode>>, new_node_rc: Rc<RefCell<LinkedListNode>>) {
        let next_node_rc = Rc::clone(prev_node_rc.borrow().next.as_ref().unwrap());

        new_node_rc.borrow_mut().prev = Some(Rc::clone(&prev_node_rc));
        new_node_rc.borrow_mut().next = Some(Rc::clone(&next_node_rc));

        prev_node_rc.borrow_mut().next = Some(Rc::clone(&new_node_rc));
        next_node_rc.borrow_mut().prev = Some(Rc::clone(&new_node_rc));

        self.count_to_node.insert(new_node_rc.borrow().count, Rc::clone(&new_node_rc));
    }

    // Helper to insert a new_node before an existing next_node
    fn insert_node_before(&mut self, next_node_rc: Rc<RefCell<LinkedListNode>>, new_node_rc: Rc<RefCell<LinkedListNode>>) {
        let prev_node_rc = Rc::clone(next_node_rc.borrow().prev.as_ref().unwrap());

        new_node_rc.borrow_mut().prev = Some(Rc::clone(&prev_node_rc));
        new_node_rc.borrow_mut().next = Some(Rc::clone(&next_node_rc));

        prev_node_rc.borrow_mut().next = Some(Rc::clone(&new_node_rc));
        next_node_rc.borrow_mut().prev = Some(Rc::clone(&new_node_rc));

        self.count_to_node.insert(new_node_rc.borrow().count, Rc::clone(&new_node_rc));
    }

    // Helper to remove a node from the list
    fn remove_node(&mut self, node_rc: Rc<RefCell<LinkedListNode>>) {
        let prev_node_rc = Rc::clone(node_rc.borrow().prev.as_ref().unwrap());
        let next_node_rc = Rc::clone(node_rc.borrow().next.as_ref().unwrap());

        prev_node_rc.borrow_mut().next = Some(Rc::clone(&next_node_rc));
        next_node_rc.borrow_mut().prev = Some(Rc::clone(&prev_node_rc));

        self.count_to_node.remove(&node_rc.borrow().count);

        // Break cycles for the removed node
        node_rc.borrow_mut().prev = None;
        node_rc.borrow_mut().next = None;
    }

    fn inc(&mut self, key: String) {
        let old_count = *self.key_to_count.get(&key).unwrap_or(&0);
        let new_count = old_count + 1;

        self.key_to_count.insert(key.clone(), new_count);

        let mut prev_node_for_new_node_rc = Rc::clone(&self.head); // Default for new keys

        // 1. Remove key from old_count's node (if old_count > 0)
        if old_count > 0 {
            let old_node_rc = self.count_to_node.get(&old_count).unwrap();
            old_node_rc.borrow_mut().keys.remove(&key);

            if old_node_rc.borrow().keys.is_empty() {
                prev_node_for_new_node_rc = Rc::clone(old_node_rc.borrow().prev.as_ref().unwrap());
                self.remove_node(Rc::clone(old_node_rc));
            } else {
                prev_node_for_new_node_rc = Rc::clone(old_node_rc);
            }
        }

        // 2. Add key to new_count's node
        if let Some(new_node_rc) = self.count_to_node.get(&new_count) {
            // Node for new_count already exists
            new_node_rc.borrow_mut().keys.insert(key);
        } else {
            // Node for new_count does not exist, create it and insert into list
            let new_node_rc = LinkedListNode::new(new_count);
            new_node_rc.borrow_mut().keys.insert(key);
            self.insert_node_after(prev_node_for_new_node_rc, new_node_rc);
        }
    }

    fn dec(&mut self, key: String) {
        let old_count = *self.key_to_count.get(&key).unwrap_or(&0);
        if old_count == 0 {
            return; // Key does not exist, do nothing
        }

        let new_count = old_count - 1;

        let mut next_node_for_new_node_rc = Rc::clone(&self.tail); // Default if old_node is removed

        // 1. Remove key from old_count's node
        let old_node_rc = self.count_to_node.get(&old_count).unwrap();
        old_node_rc.borrow_mut().keys.remove(&key);

        if old_node_rc.borrow().keys.is_empty() {
            next_node_for_new_node_rc = Rc::clone(old_node_rc.borrow().next.as_ref().unwrap());
            self.remove_node(Rc::clone(old_node_rc));
        } else {
            next_node_for_new_node_rc = Rc::clone(old_node_rc);
        }

        // 2. Update key_to_count and add key to new_count's node
        if new_count == 0 {
            self.key_to_count.remove(&key);
        } else {
            self.key_to_count.insert(key.clone(), new_count);

            if let Some(new_node_rc) = self.count_to_node.get(&new_count) {
                // Node for new_count already exists
                new_node_rc.borrow_mut().keys.insert(key);
            } else {
                // Node for new_count does not exist, create it and insert into list
                let new_node_rc = LinkedListNode::new(new_count);
                new_node_rc.borrow_mut().keys.insert(key);
                self.insert_node_before(next_node_for_new_node_rc, new_node_rc);
            }
        }
    }

    fn get_max_key(&self) -> String {
        let max_node_rc = Rc::clone(self.tail.borrow().prev.as_ref().unwrap());
        if Rc::ptr_eq(&max_node_rc, &self.head) {
            "".to_string() // No actual keys found
        } else {
            max_node_rc.borrow().keys.iter().next().unwrap().clone()
        }
    }

    fn get_min_key(&self) -> String {
        let min_node_rc = Rc::clone(self.head.borrow().next.as_ref().unwrap());
        if Rc::ptr_eq(&min_node_rc, &self.tail) {
            "".to_string() // No actual keys found
        } else {
            min_node_rc.borrow().keys.iter().next().unwrap().clone()
        }
    }
}