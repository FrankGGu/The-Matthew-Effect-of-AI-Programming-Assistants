impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

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

pub fn construct_maximum_binary_tree(nums: Vec<i32>) -> Option<Box<TreeNode>> {
    if nums.is_empty() {
        return None;
    }

    let mut nodes: Vec<Option<Box<TreeNode>>> = nums.iter().map(|&val| Some(Box::new(TreeNode::new(val)))).collect();
    let mut stack: Vec<usize> = Vec::new();

    for i in 0..nodes.len() {
        while let Some(j) = stack.last().copied() {
            if nodes[i].as_ref().unwrap().val > nodes[j].as_ref().unwrap().val {
                let j_node = nodes[j].take();
                if let Some(j_node) = j_node {
                    if let Some(k) = stack.last().copied() {
                        if nodes[k].as_ref().unwrap().val < nodes[i].as_ref().unwrap().val {
                            nodes[k].as_mut().unwrap().right = Some(j_node);
                        } else {
                            nodes[i].as_mut().unwrap().left = Some(j_node);
                        }
                    } else {
                        nodes[i].as_mut().unwrap().left = Some(j_node);
                    }
                }
                stack.pop();
            } else {
                break;
            }
        }
        stack.push(i);
    }

    while let Some(j) = stack.pop() {
        if let Some(k) = stack.last().copied() {
            if nodes[k].as_ref().unwrap().val < nodes[j].as_ref().unwrap().val {
                nodes[k].as_mut().unwrap().right = nodes[j].take();
            } else {
                nodes[j].as_mut().unwrap().left = nodes[j].take();
            }
        }
    }

    nodes[0].take()
}
}