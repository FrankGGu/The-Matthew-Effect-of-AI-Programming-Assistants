use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug)]
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

pub fn all_possible_fbt(n: i32) -> Vec<Option<Box<TreeNode>>> {
    if n % 2 == 0 {
        return Vec::new();
    }
    let mut dp: Vec<Vec<Option<Box<TreeNode>>>> = vec![vec![]; (n + 1) as usize];
    dp[1].push(Some(Box::new(TreeNode::new(0))));

    for nodes in (3..=n).step_by(2) {
        for left in (1..nodes).step_by(2) {
            let right = nodes - 1 - left;
            for left_tree in &dp[left as usize] {
                for right_tree in &dp[right as usize] {
                    let mut root = Some(Box::new(TreeNode::new(0)));
                    if let Some(ref mut node) = root {
                        node.left = left_tree.clone();
                        node.right = right_tree.clone();
                    }
                    dp[nodes as usize].push(root);
                }
            }
        }
    }

    dp[n as usize].clone()
}