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

pub fn get_target_copy(original: Option<Box<TreeNode>>, cloned: Option<Box<TreeNode>>, target: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    fn dfs(original: &Option<Box<TreeNode>>, cloned: &Option<Box<TreeNode>>, target: &Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        if original.is_none() {
            return None;
        }
        if original.as_ref().unwrap().val == target.as_ref().unwrap().val {
            return cloned.clone();
        }
        let left_result = dfs(&original.as_ref().unwrap().left, &cloned.as_ref().unwrap().left, target);
        if left_result.is_some() {
            return left_result;
        }
        dfs(&original.as_ref().unwrap().right, &cloned.as_ref().unwrap().right, target)
    }
    dfs(&original, &cloned, &target)
}