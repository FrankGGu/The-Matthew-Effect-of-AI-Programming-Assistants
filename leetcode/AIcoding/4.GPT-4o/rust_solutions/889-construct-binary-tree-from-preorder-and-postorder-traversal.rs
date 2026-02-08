use std::collections::HashMap;

#[derive(Debug, TreeNode)]
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

pub fn construct_from_pre_post(pre: Vec<i32>, post: Vec<i32>) -> Option<Box<TreeNode>> {
    let mut post_index = HashMap::new();
    for (i, &val) in post.iter().enumerate() {
        post_index.insert(val, i);
    }
    fn build(pre: &[i32], post: &[i32], pre_start: usize, pre_end: usize, post_start: usize, post_end: usize, post_index: &HashMap<i32, usize>) -> Option<Box<TreeNode>> {
        if pre_start > pre_end || post_start > post_end {
            return None;
        }
        let root_val = pre[pre_start];
        let root = Some(Box::new(TreeNode::new(root_val)));
        if pre_start + 1 <= pre_end {
            let left_val = pre[pre_start + 1];
            let left_post_index = post_index[&left_val];
            let left_size = left_post_index - post_start + 1;
            let left_subtree = build(pre, post, pre_start + 1, pre_start + left_size, post_start, left_post_index, post_index);
            let right_subtree = build(pre, post, pre_start + left_size + 1, pre_end, left_post_index + 1, post_end - 1, post_index);
            root.as_mut().unwrap().left = left_subtree;
            root.as_mut().unwrap().right = right_subtree;
        }
        root
    }
    build(&pre, &post, 0, pre.len() - 1, 0, post.len() - 1, &post_index)
}