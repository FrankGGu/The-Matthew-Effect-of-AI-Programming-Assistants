impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
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

pub fn sorted_array_to_bst(nums: Vec<i32>) -> Option<Box<TreeNode>> {
    fn helper(nums: &Vec<i32>, left: usize, right: usize) -> Option<Box<TreeNode>> {
        if left > right {
            return None;
        }
        let mid = left + (right - left) / 2;
        Some(Box::new(TreeNode {
            val: nums[mid],
            left: helper(nums, left, mid - 1),
            right: helper(nums, mid + 1, right),
        }))
    }

    helper(&nums, 0, nums.len() - 1)
}
}