use std::cmp::Ordering;
use rand::prelude::*;

struct Node {
    val: i32,
    next: Vec<Option<Box<Node>>>,
}

impl Node {
    fn new(val: i32, level: usize) -> Self {
        Node {
            val,
            next: vec![None; level],
        }
    }
}

struct Skiplist {
    head: Box<Node>,
    level: usize,
}

impl Skiplist {
    fn new() -> Self {
        Skiplist {
            head: Box::new(Node::new(-1, 32)),
            level: 1,
        }
    }

    fn random_level(&self) -> usize {
        let mut level = 1;
        while thread_rng().gen::<f64>() < 0.25 && level < 32 {
            level += 1;
        }
        level
    }

    fn find(&self, target: i32) -> Vec<Option<*mut Node>> {
        let mut update = vec![None; 32];
        let mut current = &self.head as *const Node as *mut Node;
        for i in (0..self.level).rev() {
            unsafe {
                while let Some(next) = (*current).next[i].as_ref() {
                    if next.val < target {
                        current = &**next as *const Node as *mut Node;
                    } else {
                        break;
                    }
                }
                update[i] = Some(current);
            }
        }
        update
    }

    fn search(&self, target: i32) -> bool {
        let update = self.find(target);
        unsafe {
            if let Some(node) = update[0] {
                if let Some(next) = (*node).next[0].as_ref() {
                    return next.val == target;
                }
            }
        }
        false
    }

    fn add(&mut self, num: i32) {
        let update = self.find(num);
        let level = self.random_level();
        let new_node = Box::new(Node::new(num, level));
        let new_node_ptr = Box::into_raw(new_node);
        for i in 0..level {
            unsafe {
                if let Some(node) = update[i] {
                    (*new_node_ptr).next[i] = (*node).next[i].take();
                    (*node).next[i] = Some(Box::from_raw(new_node_ptr));
                }
            }
        }
        if level > self.level {
            self.level = level;
        }
    }

    fn erase(&mut self, num: i32) -> bool {
        let update = self.find(num);
        unsafe {
            if let Some(node) = update[0] {
                if let Some(next) = (*node).next[0].as_ref() {
                    if next.val != num {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }
        let mut node_to_remove = None;
        unsafe {
            if let Some(node) = update[0] {
                node_to_remove = (*node).next[0].take();
            }
        }
        if let Some(node) = node_to_remove {
            let level = node.next.len();
            for i in 0..level {
                unsafe {
                    if let Some(prev) = update[i] {
                        (*prev).next[i] = node.next[i].take();
                    }
                }
            }
            while self.level > 1 && self.head.next[self.level - 1].is_none() {
                self.level -= 1;
            }
            true
        } else {
            false
        }
    }
}