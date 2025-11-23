impl Solution {

use std::cell::RefCell;
use std::collections::HashMap;
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

pub fn find_duplicate_subtrees(
    root: Option<Rc<RefCell<TreeNode>>>,
) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
    let mut result = Vec::new();
    let mut map = HashMap::new();
    serialize(root, &mut map, &mut result);
    result
}

fn serialize(
    node: Option<Rc<RefCell<TreeNode>>>,
    map: &mut HashMap<String, i32>,
    result: &mut Vec<Option<Rc<RefCell<TreeNode>>>>,
) -> String {
    if let Some(n) = node {
        let left = serialize(n.borrow().left.clone(), map, result);
        let right = serialize(n.borrow().right.clone(), map, result);
        let key = format!("{}({})({})", n.borrow().val, left, right);
        *map.entry(key.clone()).or_insert(0) += 1;
        if map[&key] == 2 {
            result.push(Some(n));
        }
        key
    } else {
        "".to_string()
    }
}
}