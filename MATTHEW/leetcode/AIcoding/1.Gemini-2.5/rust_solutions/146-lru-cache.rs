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
    head: Option<Rc<RefCell<Node>>>,
    tail: Option<Rc<RefCell<Node>>>,
}

impl LRUCache {
    fn new(capacity: i32) -> Self {
        LRUCache {
            capacity: capacity as usize,
            map: HashMap::new(),
            head: None,
            tail: None,
        }
    }

    fn add_to_front(&mut self, node: Rc<RefCell<Node>>) {
        node.borrow_mut().next = self.head.take();
        if let Some(old_head) = &node.borrow().next {
            old_head.borrow_mut().prev = Some(Rc::clone(&node));
        }
        self.head = Some(Rc::clone(&node));

        if self.tail.is_none() {
            self.tail = Some(Rc::clone(&node));
        }
    }

    fn remove_node(&mut self, node: Rc<RefCell<Node>>) {
        let prev = node.borrow_mut().prev.take();
        let next = node.borrow_mut().next.take();

        match (prev, next) {
            (Some(p), Some(n)) => {
                p.borrow_mut().next = Some(Rc::clone(&n));
                n.borrow_mut().prev = Some(Rc::clone(&p));
            },
            (None, Some(n)) => {
                n.borrow_mut().prev = None;
                self.head = Some(n);
            },
            (Some(p), None) => {
                p.borrow_mut().next = None;
                self.tail = Some(p);
            },
            (None, None) => {
                self.head = None;
                self.tail = None;
            },
        }
    }

    fn remove_lru(&mut self) -> Option<i32> {
        if let Some(tail_node) = self.tail.take() {
            let key = tail_node.borrow().key;
            let prev_of_tail = tail_node.borrow_mut().prev.take();

            if let Some(prev) = prev_of_tail {
                prev.borrow_mut().next = None;
                self.tail = Some(prev);
            } else {
                self.head = None;
                self.tail = None;
            }
            Some(key)
        } else {
            None
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        if let Some(node_rc) = self.map.get(&key) {
            let value = node_rc.borrow().value;

            self.remove_node(Rc::clone(node_rc));
            self.add_to_front(Rc::clone(node_rc));

            value
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        if let Some(node_rc) = self.map.get(&key) {
            node_rc.borrow_mut().value = value;
            self.remove_node(Rc::clone(node_rc));
            self.add_to_front(Rc::clone(node_rc));
        } else {
            let new_node_rc = Node::new(key, value);
            self.map.insert(key, Rc::clone(&new_node_rc));
            self.add_to_front(new_node_rc);

            if self.map.len() > self.capacity {
                if let Some(lru_key) = self.remove_lru() {
                    self.map.remove(&lru_key);
                }
            }
        }
    }
}