use std::collections::HashMap;
use std::rc::Rc;
use std::cell::RefCell;

struct Node {
    key: i32,
    value: i32,
    prev: Option<Rc<RefCell<Node>>>,
    next: Option<Rc<RefCell<Node>>>,
}

impl Node {
    fn new(key: i32, value: i32) -> Rc<RefCell<Self>> {
        Rc::new(RefCell::new(Node {
            key,
            value,
            prev: None,
            next: None,
        }))
    }
}

struct LRUCache {
    capacity: usize,
    map: HashMap<i32, Rc<RefCell<Node>>>,
    head: Rc<RefCell<Node>>,
    tail: Rc<RefCell<Node>>,
}

impl LRUCache {
    fn new(capacity: i32) -> Self {
        let head = Node::new(0, 0);
        let tail = Node::new(0, 0);

        head.borrow_mut().next = Some(Rc::clone(&tail));
        tail.borrow_mut().prev = Some(Rc::clone(&head));

        LRUCache {
            capacity: capacity as usize,
            map: HashMap::new(),
            head,
            tail,
        }
    }

    fn remove_node(&self, node: &Rc<RefCell<Node>>) {
        let prev_node = node.borrow().prev.as_ref().unwrap().clone();
        let next_node = node.borrow().next.as_ref().unwrap().clone();

        prev_node.borrow_mut().next = Some(Rc::clone(&next_node));
        next_node.borrow_mut().prev = Some(Rc::clone(&prev_node));
    }

    fn add_to_head(&self, node: &Rc<RefCell<Node>>) {
        let next_node = self.head.borrow().next.as_ref().unwrap().clone();

        node.borrow_mut().next = Some(Rc::clone(&next_node));
        node.borrow_mut().prev = Some(Rc::clone(&self.head));

        self.head.borrow_mut().next = Some(Rc::clone(node));
        next_node.borrow_mut().prev = Some(Rc::clone(node));
    }

    fn get(&mut self, key: i32) -> i32 {
        if let Some(node_rc) = self.map.get(&key) {
            let value = node_rc.borrow().value;
            self.remove_node(node_rc);
            self.add_to_head(node_rc);
            value
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        if let Some(node_rc) = self.map.get(&key) {
            node_rc.borrow_mut().value = value;
            self.remove_node(node_rc);
            self.add_to_head(node_rc);
        } else {
            let new_node = Node::new(key, value);
            self.map.insert(key, Rc::clone(&new_node));
            self.add_to_head(&new_node);

            if self.map.len() > self.capacity {
                let lru_node_rc = self.tail.borrow().prev.as_ref().unwrap().clone();
                self.remove_node(&lru_node_rc);
                self.map.remove(&lru_node_rc.borrow().key);
            }
        }
    }
}