use crate::TreeNode;

impl Solution {
    pub fn is_symmetric(root: Option<Box<TreeNode>>) -> bool {
        fn is_mirror(t1: Option<&Box<TreeNode>>, t2: Option<&Box<TreeNode>>) -> bool {
            match (t1, t2) {
                (None, None) => true,
                (Some(_), None) | (None, Some(_)) => false,
                (Some(node1), Some(node2)) => {
                    node1.val == node2.val &&
                    is_mirror(node1.left.as_ref(), node2.right.as_ref()) &&
                    is_mirror(node1.right.as_ref(), node2.left.as_ref())
                }
            }
        }
        is_mirror(root.as_ref(), root.as_ref())
    }
}