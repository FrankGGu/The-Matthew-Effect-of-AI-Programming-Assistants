#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn sorted_array_to_bst(nums: Vec<i32>) -> Option<Box<TreeNode>> {
    fn build_bst(nums: &[i32], left: usize, right: usize) -> Option<Box<TreeNode>> {
        if left > right {
            return None;
        }
        let mid = (left + right) / 2;
        let mut node = TreeNode::new(nums[mid]);
        node.left = build_bst(nums, left, mid - 1);
        node.right = build_bst(nums, mid + 1, right);
        Some(Box::new(node))
    }
    build_bst(&nums, 0, nums.len() as usize - 1)
}