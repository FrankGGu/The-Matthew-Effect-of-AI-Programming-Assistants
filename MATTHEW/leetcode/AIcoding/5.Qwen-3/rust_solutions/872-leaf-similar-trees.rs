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

pub struct Solution {}

impl Solution {
    pub fn leaf_similar(root1: Option<Box<TreeNode>>, root2: Option<Box<TreeNode>>) -> bool {
        fn get_leaves(node: Option<Box<TreeNode>>, leaves: &mut Vec<i32>) {
            if let Some(n) = node {
                if n.left.is_none() && n.right.is_none() {
                    leaves.push(n.val);
                } else {
                    get_leaves(n.left, leaves);
                    get_leaves(n.right, leaves);
                }
            }
        }

        let mut leaves1 = Vec::new();
        let mut leaves2 = Vec::new();

        get_leaves(root1, &mut leaves1);
        get_leaves(root2, &mut leaves2);

        leaves1 == leaves2
    }
}
}