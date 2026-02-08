use std::collections::HashMap;

#[derive(TreeNode)]
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

pub fn build_tree(inorder: Vec<i32>, postorder: Vec<i32>) -> Option<Box<TreeNode>> {
    let mut inorder_map = HashMap::new();
    for (i, &val) in inorder.iter().enumerate() {
        inorder_map.insert(val, i);
    }
    fn construct_tree(
        inorder: &[i32],
        postorder: &[i32],
        inorder_map: &HashMap<i32, usize>,
        in_start: usize,
        in_end: usize,
        post_start: usize,
        post_end: usize,
    ) -> Option<Box<TreeNode>> {
        if in_start > in_end || post_start > post_end {
            return None;
        }
        let root_val = postorder[post_end];
        let root = Some(Box::new(TreeNode::new(root_val)));
        let root_index = *inorder_map.get(&root_val).unwrap();
        let left_size = root_index - in_start;
        let right_size = in_end - root_index;
        let left = construct_tree(
            inorder,
            postorder,
            inorder_map,
            in_start,
            root_index - 1,
            post_start,
            post_start + left_size - 1,
        );
        let right = construct_tree(
            inorder,
            postorder,
            inorder_map,
            root_index + 1,
            in_end,
            post_start + left_size,
            post_end - 1,
        );
        root.map(|node| {
            node.left = left;
            node.right = right;
            node
        })
    }
    construct_tree(&inorder, &postorder, &inorder_map, 0, inorder.len() - 1, 0, postorder.len() - 1)
}