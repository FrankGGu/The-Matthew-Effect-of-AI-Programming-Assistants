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

pub struct Solution {}

impl Solution {
    pub fn postorder_traversal(root: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut stack = Vec::new();
        let mut last_visited = None;

        let mut current = root;

        while current.is_some() || !stack.is_empty() {
            if let Some(node) = current {
                stack.push(node);
                current = node.left;
            } else {
                let node = stack.last().unwrap();
                if node.right.is_none() || Some(node.right.as_ref().unwrap()) == last_visited {
                    result.push(node.val);
                    last_visited = stack.pop();
                } else {
                    current = node.right.take();
                }
            }
        }

        result
    }
}
}