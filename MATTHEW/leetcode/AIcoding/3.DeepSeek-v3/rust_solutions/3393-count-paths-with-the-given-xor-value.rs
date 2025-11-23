use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn count_paths(root: Option<Rc<RefCell<TreeNode>>>, target: i32) -> i32 {
        let mut prefix = HashMap::new();
        prefix.insert(0, 1);
        Self::dfs(root, 0, target, &mut prefix)
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, current_xor: i32, target: i32, prefix: &mut HashMap<i32, i32>) -> i32 {
        match node {
            None => 0,
            Some(n) => {
                let node = n.borrow();
                let new_xor = current_xor ^ node.val;
                let mut count = *prefix.get(&(new_xor ^ target)).unwrap_or(&0);
                *prefix.entry(new_xor).or_insert(0) += 1;

                count += Self::dfs(node.left.clone(), new_xor, target, prefix);
                count += Self::dfs(node.right.clone(), new_xor, target, prefix);

                *prefix.entry(new_xor).or_insert(0) -= 1;
                if prefix[&new_xor] == 0 {
                    prefix.remove(&new_xor);
                }
                count
            }
        }
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