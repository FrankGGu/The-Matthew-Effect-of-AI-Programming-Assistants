impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<TreeNode>,
    pub right: Option<TreeNode>,
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

pub fn lowest_common_ancestor(
    root: Option<&TreeNode>,
    p: Option<&TreeNode>,
    q: Option<&TreeNode>,
) -> Option<&TreeNode> {
    let mut current = root;
    while let Some(node) = current {
        let val = node.val;
        let p_val = p.unwrap().val;
        let q_val = q.unwrap().val;
        if p_val < val && q_val < val {
            current = node.left;
        } else if p_val > val && q_val > val {
            current = node.right;
        } else {
            return Some(node);
        }
    }
    None
}
}