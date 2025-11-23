impl Solution {

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

pub fn min_time_to_collect_all_apples(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, has_apple: &mut Vec<bool>) -> bool {
        if let Some(n) = node {
            let mut res = false;
            let mut left = false;
            let mut right = false;

            if let Some(left_child) = &n.borrow().left {
                left = dfs(&Some(left_child.clone()), has_apple);
            }

            if let Some(right_child) = &n.borrow().right {
                right = dfs(&Some(right_child.clone()), has_apple);
            }

            res = left || right || n.borrow().val == 1;

            if res {
                has_apple[n.borrow().val as usize] = true;
            }

            res
        } else {
            false
        }
    }

    let mut max_val = 0;
    let mut stack = vec![];
    let mut node = &root;
    while let Some(n) = node {
        max_val = std::cmp::max(max_val, n.borrow().val);
        stack.push(n.clone());
        node = &n.borrow().left;
    }

    let mut has_apple = vec![false; max_val as usize + 1];
    dfs(&root, &mut has_apple);

    let mut res = 0;
    let mut stack = vec![];
    let mut node = &root;
    while let Some(n) = node {
        stack.push(n.clone());
        node = &n.borrow().left;
    }

    while let Some(n) = stack.pop() {
        let left = n.borrow().left.as_ref();
        let right = n.borrow().right.as_ref();

        if left.is_some() && has_apple[n.borrow().val as usize] {
            res += 2;
        }

        if right.is_some() && has_apple[n.borrow().val as usize] {
            res += 2;
        }
    }

    res
}
}