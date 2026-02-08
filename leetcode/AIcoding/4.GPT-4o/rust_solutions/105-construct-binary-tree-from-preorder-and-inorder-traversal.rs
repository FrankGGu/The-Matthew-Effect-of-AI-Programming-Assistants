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

pub fn build_tree(preorder: Vec<i32>, inorder: Vec<i32>) -> Option<Box<TreeNode>> {
    let mut inorder_map = HashMap::new();
    for (i, &val) in inorder.iter().enumerate() {
        inorder_map.insert(val, i);
    }

    fn build(preorder: &[i32], inorder_map: &HashMap<i32, usize>, inorder_start: usize, inorder_end: usize, pre_index: &mut usize) -> Option<Box<TreeNode>> {
        if inorder_start > inorder_end {
            return None;
        }

        let root_val = preorder[*pre_index];
        *pre_index += 1;

        let root = Some(Box::new(TreeNode::new(root_val)));
        let inorder_index = *inorder_map.get(&root_val).unwrap();

        if let Some(ref mut root_node) = root {
            root_node.left = build(preorder, inorder_map, inorder_start, inorder_index as usize - 1, pre_index);
            root_node.right = build(preorder, inorder_map, inorder_index as usize + 1, inorder_end, pre_index);
        }

        root
    }

    let mut pre_index = 0;
    build(&preorder, &inorder_map, 0, inorder.len() - 1, &mut pre_index)
}