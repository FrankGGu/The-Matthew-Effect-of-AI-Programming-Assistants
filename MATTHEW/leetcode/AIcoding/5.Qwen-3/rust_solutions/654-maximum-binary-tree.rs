impl Solution {

use std::cmp::Ordering;
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

struct Solution;

impl Solution {
    pub fn construct_maximum_binary_tree(nums: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::build(&nums[..])
    }

    fn build(nums: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if nums.is_empty() {
            return None;
        }

        let max_index = Self::find_max_index(nums);
        let root_val = nums[max_index];

        let left_nums = &nums[..max_index];
        let right_nums = &nums[max_index + 1..];

        let left = Self::build(left_nums);
        let right = Self::build(right_nums);

        Some(Rc::new(RefCell::new(TreeNode {
            val: root_val,
            left,
            right,
        })))
    }

    fn find_max_index(nums: &[i32]) -> usize {
        let mut max_index = 0;
        for (i, &num) in nums.iter().enumerate() {
            if num > nums[max_index] {
                max_index = i;
            }
        }
        max_index
    }
}
}