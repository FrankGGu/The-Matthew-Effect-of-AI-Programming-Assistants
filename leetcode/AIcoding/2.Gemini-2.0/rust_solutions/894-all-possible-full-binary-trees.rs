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

impl Solution {
    pub fn all_possible_fbt(n: i32) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        if n % 2 == 0 {
            return vec![];
        }

        if n == 1 {
            return vec![Some(Rc::new(RefCell::new(TreeNode::new(0))))];
        }

        let mut result = vec![];
        for i in (1..n).step_by(2) {
            let left_trees = Solution::all_possible_fbt(i);
            let right_trees = Solution::all_possible_fbt(n - i - 1);

            for left in &left_trees {
                for right in &right_trees {
                    let root = TreeNode {
                        val: 0,
                        left: left.clone(),
                        right: right.clone(),
                    };
                    result.push(Some(Rc::new(RefCell::new(root))));
                }
            }
        }

        result
    }
}

struct Solution;