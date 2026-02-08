use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
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
    pub fn find_duplicate_subtrees(
        root: Option<Rc<RefCell<TreeNode>>>,
    ) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let mut subtree_map: HashMap<String, i32> = HashMap::new();
        let mut result: Vec<Option<Rc<RefCell<TreeNode>>>> = Vec::new();
        let mut seen: HashSet<String> = HashSet::new();

        fn traverse(
            node: Option<Rc<RefCell<TreeNode>>>,
            subtree_map: &mut HashMap<String, i32>,
            result: &mut Vec<Option<Rc<RefCell<TreeNode>>>>,
            seen: &mut HashSet<String>,
        ) -> String {
            if let Some(n) = node.clone() {
                let node_borrow = n.borrow();
                let left_str = traverse(node_borrow.left.clone(), subtree_map, result, seen);
                let right_str = traverse(node_borrow.right.clone(), subtree_map, result, seen);
                let subtree_str = format!("{},{},{}", node_borrow.val, left_str, right_str);

                let count = subtree_map.entry(subtree_str.clone()).or_insert(0);
                *count += 1;

                if *count == 2 && !seen.contains(&subtree_str) {
                    result.push(node.clone());
                    seen.insert(subtree_str.clone());
                }

                subtree_str
            } else {
                "null".to_string()
            }
        }

        traverse(root, &mut subtree_map, &mut result, &mut seen);
        result
    }
}

struct Solution;