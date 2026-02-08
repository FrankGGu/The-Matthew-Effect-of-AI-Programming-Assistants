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
    pub fn construct_maximum_binary_tree(nums: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        if nums.is_empty() {
            return None;
        }

        let max_val = *nums.iter().max().unwrap();
        let max_index = nums.iter().position(|&x| x == max_val).unwrap();

        let mut root = TreeNode::new(max_val);
        root.left = Solution::construct_maximum_binary_tree(nums[..max_index].to_vec());
        root.right = Solution::construct_maximum_binary_tree(nums[max_index + 1..].to_vec());

        Some(Rc::new(RefCell::new(root)))
    }
}

struct Solution;