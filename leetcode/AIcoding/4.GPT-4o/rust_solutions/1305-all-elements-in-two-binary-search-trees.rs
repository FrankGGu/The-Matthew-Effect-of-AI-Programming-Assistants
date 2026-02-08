use std::collections::VecDeque;
use std::cmp::Ord;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn get_all_elements(root1: Option<Box<TreeNode>>, root2: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut elements = Vec::new();
        let mut stack1 = VecDeque::new();
        let mut stack2 = VecDeque::new();

        let mut current1 = root1;
        let mut current2 = root2;

        while current1.is_some() || current2.is_some() || !stack1.is_empty() || !stack2.is_empty() {
            while let Some(node) = current1 {
                stack1.push_back(node);
                current1 = node.left;
            }
            while let Some(node) = current2 {
                stack2.push_back(node);
                current2 = node.left;
            }

            if stack2.is_empty() || (!stack1.is_empty() && stack1.back().unwrap().val <= stack2.back().unwrap().val) {
                if let Some(node) = stack1.pop_back() {
                    elements.push(node.val);
                    current1 = node.right;
                }
            } else {
                if let Some(node) = stack2.pop_back() {
                    elements.push(node.val);
                    current2 = node.right;
                }
            }
        }

        elements
    }
}