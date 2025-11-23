use rand::Rng;
use std::rc::Rc;
use std::cell::RefCell;

const MAX_LEVEL: usize = 16;
const P: f64 = 0.5;

struct Node {
    val: i32,
    next: Vec<Option<Rc<RefCell<Node>>>>,
}

impl Node {
    fn new(val: i32, level: usize) -> Rc<RefCell<Self>> {
        Rc::new(RefCell::new(Node {
            val,
            next: vec![None; level + 1],
        }))
    }
}

struct Skiplist {
    head: Rc<RefCell<Node>>,
    level: usize,
    rng: rand::rngs::ThreadRng,
}

impl Skiplist {
    fn new() -> Self {
        Skiplist {
            head: Node::new(-1, MAX_LEVEL),
            level: 0,
            rng: rand::thread_rng(),
        }
    }

    fn random_level(&mut self) -> usize {
        let mut lvl = 0;
        while self.rng.gen::<f64>() < P && lvl < MAX_LEVEL {
            lvl += 1;
        }
        lvl
    }

    fn search(&self, target: i32) -> bool {
        let mut curr = Rc::clone(&self.head);

        for i in (0..=self.level).rev() {
            while let Some(next_node) = &curr.borrow().next[i] {
                if next_node.borrow().val < target {
                    curr = Rc::clone(next_node);
                } else {
                    break;
                }
            }
        }

        if let Some(node_at_level_0) = &curr.borrow().next[0] {
            return node_at_level_0.borrow().val == target;
        }
        false
    }

    fn add(&mut self, num: i32) {
        let mut update: Vec<Option<Rc<RefCell<Node>>>> = vec![None; MAX_LEVEL + 1];
        let mut curr = Rc::clone(&self.head);

        for i in (0..=self.level).rev() {
            while let Some(next_node) = &curr.borrow().next[i] {
                if next_node.borrow().val < num {
                    curr = Rc::clone(next_node);
                } else {
                    break;
                }
            }
            update[i] = Some(Rc::clone(&curr));
        }

        let new_node_level = self.random_level();

        if new_node_level > self.level {
            for i in (self.level + 1)..=new_node_level {
                update[i] = Some(Rc::clone(&self.head));
            }
            self.level = new_node_level;
        }

        let new_node = Node::new(num, new_node_level);

        for i in 0..=new_node_level {
            if let Some(prev_node_rc) = &update[i] {
                let mut prev_node = prev_node_rc.borrow_mut();
                new_node.borrow_mut().next[i] = prev_node.next[i].take();
                prev_node.next[i] = Some(Rc::clone(&new_node));
            }
        }
    }

    fn erase(&mut self, num: i32) -> bool {
        let mut update: Vec<Option<Rc<RefCell<Node>>>> = vec![None; MAX_LEVEL + 1];
        let mut curr = Rc::clone(&self.head);

        for i in (0..=self.level).rev() {
            while let Some(next_node) = &curr.borrow().next[i] {
                if next_node.borrow().val < num {
                    curr = Rc::clone(next_node);
                } else {
                    break;
                }
            }
            update[i] = Some(Rc::clone(&curr));
        }

        let node_to_delete_option = if let Some(node_at_level_0) = &curr.borrow().next[0] {
            if node_at_level_0.borrow().val == num {
                Some(Rc::clone(node_at_level_0))
            } else {
                None
            }
        } else {
            None
        };

        if let Some(node_to_delete) = node_to_delete_option {
            let delete_level = node_to_delete.borrow().next.len() - 1;
            for i in 0..=delete_level {
                if let Some(prev_node_rc) = &update[i] {
                    let mut prev_node = prev_node_rc.borrow_mut();
                    if let Some(next_of_prev) = &prev_node.next[i] {
                        if Rc::ptr_eq(next_of_prev, &node_to_delete) {
                            prev_node.next[i] = node_to_delete.borrow().next[i].clone();
                        }
                    }
                }
            }

            while self.level > 0 && self.head.borrow().next[self.level].is_none() {
                self.level -= 1;
            }
            true
        } else {
            false
        }
    }
}