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
    pub fn get_target_copy(
        &self,
        original: Option<Box<TreeNode>>,
        target: Option<Box<TreeNode>>,
    ) -> Option<Box<TreeNode>> {
        fn dfs(
            o: &Option<Box<TreeNode>>,
            t: &Option<Box<TreeNode>>,
        ) -> Option<Box<TreeNode>> {
            if o.is_none() {
                return None;
            }

            let o_node = o.as_ref().unwrap();
            let t_node = t.as_ref().unwrap();

            if o_node.val == t_node.val {
                return Some(Box::new(TreeNode {
                    val: o_node.val,
                    left: dfs(&o_node.left, &t_node.left),
                    right: dfs(&o_node.right, &t_node.right),
                }));
            }

            let left = dfs(&o_node.left, &t_node.left);
            if left.is_some() {
                return left;
            }

            dfs(&o_node.right, &t_node.right)
        }

        dfs(&original, &target)
    }
}
}