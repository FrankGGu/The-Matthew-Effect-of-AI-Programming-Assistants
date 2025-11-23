use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn replace_value_in_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let root = if let Some(node) = root {
            node
        } else {
            return None;
        };

        let mut queue = VecDeque::new();
        queue.push_back(root.clone());

        let mut level_sum = HashMap::new();
        let mut parent_map = HashMap::new();
        let mut level = 0;

        while !queue.is_empty() {
            let len = queue.len();
            let mut sum = 0;
            for _ in 0..len {
                let node = queue.pop_front().unwrap();
                let node_ref = node.borrow();
                sum += node_ref.val;

                if let Some(left) = &node_ref.left {
                    parent_map.insert(left.as_ptr(), node.as_ptr());
                    queue.push_back(left.clone());
                }
                if let Some(right) = &node_ref.right {
                    parent_map.insert(right.as_ptr(), node.as_ptr());
                    queue.push_back(right.clone());
                }
            }
            level_sum.insert(level, sum);
            level += 1;
        }

        let mut queue = VecDeque::new();
        queue.push_back((root.clone(), 0));

        while !queue.is_empty() {
            let len = queue.len();
            for _ in 0..len {
                let (node, current_level) = queue.pop_front().unwrap();
                let parent_ptr = parent_map.get(&node.as_ptr()).copied();
                let mut sum = level_sum[&current_level];
                let mut sibling_val = 0;

                if let Some(parent_ptr) = parent_ptr {
                    let parent = unsafe { Rc::from_raw(parent_ptr) };
                    let parent_ref = parent.borrow();
                    if let Some(left) = &parent_ref.left {
                        sibling_val += left.borrow().val;
                    }
                    if let Some(right) = &parent_ref.right {
                        sibling_val += right.borrow().val;
                    }
                    std::mem::forget(parent);
                } else {
                    sibling_val = node.borrow().val;
                }

                sum -= sibling_val;
                node.borrow_mut().val = sum;

                let node_ref = node.borrow();
                if let Some(left) = &node_ref.left {
                    queue.push_back((left.clone(), current_level + 1));
                }
                if let Some(right) = &node_ref.right {
                    queue.push_back((right.clone(), current_level + 1));
                }
            }
        }

        Some(root)
    }
}