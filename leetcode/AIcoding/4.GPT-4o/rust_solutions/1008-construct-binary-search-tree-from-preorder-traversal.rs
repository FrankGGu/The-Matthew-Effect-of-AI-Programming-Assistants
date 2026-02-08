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

pub fn bst_from_preorder(preorder: Vec<i32>) -> Option<Box<TreeNode>> {
    fn construct(preorder: &[i32], lower: i32, upper: i32, index: &mut usize) -> Option<Box<TreeNode>> {
        if index >= &mut preorder.len() || preorder[*index] < lower || preorder[*index] > upper {
            return None;
        }
        let root_val = preorder[*index];
        *index += 1;
        let root = Some(Box::new(TreeNode::new(root_val)));
        root.as_ref().unwrap().left = construct(preorder, lower, root_val, index);
        root.as_ref().unwrap().right = construct(preorder, root_val, upper, index);
        root
    }

    let mut index = 0;
    construct(&preorder, i32::MIN, i32::MAX, &mut index)
}