use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn can_merge(trees: Vec<Option<Rc<RefCell<TreeNode>>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut leaves = HashSet::new();
        let mut root_map = HashMap::new();
        let mut root_val = None;

        for tree in &trees {
            if let Some(node) = tree {
                let node_ref = node.borrow();
                if let Some(left) = &node_ref.left {
                    leaves.insert(left.borrow().val);
                }
                if let Some(right) = &node_ref.right {
                    leaves.insert(right.borrow().val);
                }
                root_map.insert(node_ref.val, tree.clone());
            }
        }

        for tree in &trees {
            if let Some(node) = tree {
                let node_ref = node.borrow();
                if !leaves.contains(&node_ref.val) {
                    if root_val.is_some() {
                        return None;
                    }
                    root_val = Some(node_ref.val);
                }
            }
        }

        if root_val.is_none() {
            return None;
        }
        let root_val = root_val.unwrap();
        let root = root_map.get(&root_val).unwrap().clone();

        let mut stack = Vec::new();
        let mut prev = None;
        let mut current = root.clone();
        let mut seen = HashSet::new();

        while !stack.is_empty() || current.is_some() {
            while let Some(node) = current {
                seen.insert(node.borrow().val);
                stack.push(node.clone());
                current = node.borrow().left.clone();
            }
            if let Some(node) = stack.pop() {
                if let Some(p) = prev {
                    if node.borrow().val <= p {
                        return None;
                    }
                }
                prev = Some(node.borrow().val);
                if let Some(right) = &node.borrow().right {
                    current = Some(right.clone());
                } else {
                    current = None;
                }
            }
        }

        for tree in &trees {
            if let Some(node) = tree {
                let node_ref = node.borrow();
                if !seen.contains(&node_ref.val) {
                    return None;
                }
                if let Some(left) = &node_ref.left {
                    if root_map.contains_key(&left.borrow().val) {
                        return None;
                    }
                }
                if let Some(right) = &node_ref.right {
                    if root_map.contains_key(&right.borrow().val) {
                        return None;
                    }
                }
            }
        }

        root
    }
}