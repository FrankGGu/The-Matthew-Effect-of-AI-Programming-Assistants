use std::cell::RefCell;
use std::rc::Rc;

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

impl Solution {
    pub fn can_merge(trees: Vec<Option<Rc<RefCell<TreeNode>>>>) -> Option<Rc<RefCell<TreeNode>>> {
        use std::collections::HashMap;

        let mut roots = HashMap::new();
        let mut children = HashMap::new();

        for tree in &trees {
            if let Some(node) = tree {
                let val = node.borrow().val;
                roots.insert(val, Rc::clone(node));

                if let Some(left) = &node.borrow().left {
                    children.insert(left.borrow().val, Rc::clone(left));
                }
                if let Some(right) = &node.borrow().right {
                    children.insert(right.borrow().val, Rc::clone(right));
                }
            }
        }

        let mut potential_roots: Vec<i32> = roots.keys().cloned().collect();
        potential_roots.retain(|&x| !children.contains_key(&x));

        if potential_roots.len() != 1 {
            return None;
        }

        let root_val = potential_roots[0];
        let root = roots.remove(&root_val).unwrap();

        let mut merged_tree = Some(Rc::clone(&root));
        let mut count = 0;

        fn is_bst(node: &Option<Rc<RefCell<TreeNode>>>, min_val: i32, max_val: i32) -> bool {
            if let Some(n) = node {
                let val = n.borrow().val;
                if val <= min_val || val >= max_val {
                    return false;
                }
                return is_bst(&n.borrow().left, min_val, val) && is_bst(&n.borrow().right, val, max_val);
            }
            true
        }

        fn dfs(node: &mut Option<Rc<RefCell<TreeNode>>>, roots: &mut HashMap<i32, Rc<RefCell<TreeNode>>>, count: &mut i32) {
            if let Some(n) = node {
                *count += 1;
                let left_val = n.borrow().val;

                if let Some(left) = roots.remove(&left_val) {
                    n.borrow_mut().left = Some(Rc::clone(&left));
                    dfs(&mut n.borrow_mut().left, roots, count);
                }

                let right_val = n.borrow().val;

                if let Some(right) = roots.remove(&right_val) {
                    n.borrow_mut().right = Some(Rc::clone(&right));
                    dfs(&mut n.borrow_mut().right, roots, count);
                }
            }
        }

        dfs(&mut merged_tree, &mut roots, &mut count);

        if !roots.is_empty() {
            return None;
        }

        if count != trees.len() {
            return None;
        }

        if !is_bst(&merged_tree, i32::MIN, i32::MAX) {
            return None;
        }

        merged_tree
    }
}

struct Solution;