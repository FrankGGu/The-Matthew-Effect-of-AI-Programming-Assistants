use std::rc::Rc;
use std::cell::RefCell;

struct Node {
    val: i32,
    next: Option<Rc<RefCell<Node>>>,
}

impl Node {
    fn new(val: i32) -> Rc<RefCell<Self>> {
        Rc::new(RefCell::new(Node { val, next: None }))
    }
}

struct MyLinkedList {
    head: Option<Rc<RefCell<Node>>>,
    size: i32,
}

impl MyLinkedList {
    fn new() -> Self {
        MyLinkedList {
            head: None,
            size: 0,
        }
    }

    fn get(&self, index: i32) -> i32 {
        if index < 0 || index >= self.size {
            return -1;
        }

        let mut current = self.head.as_ref().unwrap().clone();
        for _ in 0..index {
            let next_node = current.borrow().next.as_ref().unwrap().clone();
            current = next_node;
        }
        current.borrow().val
    }

    fn add_at_head(&mut self, val: i32) {
        let new_node = Node::new(val);
        if let Some(old_head) = self.head.take() {
            new_node.borrow_mut().next = Some(old_head);
        }
        self.head = Some(new_node);
        self.size += 1;
    }

    fn add_at_tail(&mut self, val: i32) {
        if self.head.is_none() {
            self.add_at_head(val);
            return;
        }

        let new_node = Node::new(val);
        let mut current = self.head.as_ref().unwrap().clone();
        while let Some(next_node) = current.borrow().next.as_ref() {
            current = next_node.clone();
        }
        current.borrow_mut().next = Some(new_node);
        self.size += 1;
    }

    fn add_at_index(&mut self, index: i32, val: i32) {
        if index < 0 || index > self.size {
            return;
        }
        if index == 0 {
            self.add_at_head(val);
            return;
        }
        if index == self.size {
            self.add_at_tail(val);
            return;
        }

        let new_node = Node::new(val);
        let mut current = self.head.as_ref().unwrap().clone();
        for _ in 0..(index - 1) {
            let next_node = current.borrow().next.as_ref().unwrap().clone();
            current = next_node;
        }

        let next_of_current = current.borrow_mut().next.take();
        new_node.borrow_mut().next = next_of_current;
        current.borrow_mut().next = Some(new_node);
        self.size += 1;
    }

    fn delete_at_index(&mut self, index: i32) {
        if index < 0 || index >= self.size {
            return;
        }

        if index == 0 {
            let old_head = self.head.take().unwrap();
            self.head = old_head.borrow_mut().next.take();
        } else {
            let mut current = self.head.as_ref().unwrap().clone();
            for _ in 0..(index - 1) {
                let next_node = current.borrow().next.as_ref().unwrap().clone();
                current = next_node;
            }
            let node_to_delete = current.borrow_mut().next.take().unwrap();
            let next_of_deleted = node_to_delete.borrow_mut().next.take();
            current.borrow_mut().next = next_of_deleted;
        }
        self.size -= 1;
    }
}