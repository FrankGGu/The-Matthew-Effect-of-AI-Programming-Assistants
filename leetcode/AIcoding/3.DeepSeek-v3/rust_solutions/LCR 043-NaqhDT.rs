use std::collections::VecDeque;

struct CBTInserter {
    root: Option<Rc<RefCell<TreeNode>>>,
    queue: VecDeque<Rc<RefCell<TreeNode>>>,
}

impl CBTInserter {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut queue = VecDeque::new();
        if let Some(node) = root.clone() {
            queue.push_back(node);
            while let Some(front) = queue.front() {
                let front = front.borrow();
                if front.left.is_none() || front.right.is_none() {
                    break;
                }
                let left = front.left.clone().unwrap();
                let right = front.right.clone().unwrap();
                queue.pop_front();
                queue.push_back(left);
                queue.push_back(right);
            }
        }
        CBTInserter { root, queue }
    }

    fn insert(&mut self, v: i32) -> i32 {
        let new_node = Rc::new(RefCell::new(TreeNode::new(v)));
        let parent_val = {
            let front = self.queue.front().unwrap();
            let mut front = front.borrow_mut();
            if front.left.is_none() {
                front.left = Some(new_node.clone());
            } else {
                front.right = Some(new_node.clone());
                let parent = self.queue.pop_front().unwrap();
                self.queue.push_back(parent.borrow().left.clone().unwrap());
                self.queue.push_back(new_node);
            }
            front.val
        };
        parent_val
    }

    fn get_root(&self) -> Option<Rc<RefCell<TreeNode>>> {
        self.root.clone()
    }
}

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}