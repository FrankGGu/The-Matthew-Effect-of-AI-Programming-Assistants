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

pub fn is_sub_structure(a: Option<Box<TreeNode>>, b: Option<Box<TreeNode>>) -> bool {
    fn helper(a: &Option<Box<TreeNode>>, b: &Option<Box<TreeNode>>) -> bool {
        match (a, b) {
            (None, None) => true,
            (None, _) => false,
            (_, None) => true,
            (Some(a_node), Some(b_node)) => {
                if a_node.val == b_node.val
                    && helper(&a_node.left, &b_node.left)
                    && helper(&a_node.right, &b_node.right)
                {
                    return true;
                }
                helper(&a_node.left, b) || helper(&a_node.right, b)
            }
        }
    }

    helper(&a, &b)
}
}