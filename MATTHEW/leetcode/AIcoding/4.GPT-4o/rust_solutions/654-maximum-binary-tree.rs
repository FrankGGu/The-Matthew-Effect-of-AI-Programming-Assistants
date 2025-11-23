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

pub fn construct_maximum_binary_tree(nums: Vec<i32>) -> Option<Box<TreeNode>> {
    if nums.is_empty() {
        return None;
    }

    let max_index = nums.iter().position(|&x| x == *nums.iter().max().unwrap()).unwrap();

    let mut root = TreeNode::new(nums[max_index]);
    root.left = construct_maximum_binary_tree(nums[0..max_index].to_vec());
    root.right = construct_maximum_binary_tree(nums[max_index + 1..].to_vec());

    Some(Box::new(root))
}