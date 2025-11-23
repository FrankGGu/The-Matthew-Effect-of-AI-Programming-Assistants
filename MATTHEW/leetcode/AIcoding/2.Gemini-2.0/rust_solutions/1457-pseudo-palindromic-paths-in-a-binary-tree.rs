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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn pseudo_palindromic_paths(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, mut counts: [i32; 10]) -> i32 {
            match node {
                Some(n) => {
                    let val = n.borrow().val as usize;
                    counts[val] += 1;

                    if n.borrow().left.is_none() && n.borrow().right.is_none() {
                        let mut odd_count = 0;
                        for &count in &counts {
                            if count % 2 != 0 {
                                odd_count += 1;
                            }
                        }
                        if odd_count <= 1 {
                            1
                        } else {
                            0
                        }
                    } else {
                        let left_count = dfs(n.borrow().left.clone(), counts);
                        let right_count = dfs(n.borrow().right.clone(), counts);
                        left_count + right_count
                    }
                }
                None => 0,
            }
        }

        dfs(root, [0; 10])
    }
}

struct Solution;