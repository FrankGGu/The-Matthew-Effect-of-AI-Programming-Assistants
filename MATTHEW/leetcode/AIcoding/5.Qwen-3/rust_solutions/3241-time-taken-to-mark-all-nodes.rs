impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>,
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

pub fn time_required_to_mark_all_nodes(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, parent: &Option<Box<TreeNode>>, depth: i32, map: &mut HashMap<i32, i32>) {
        if let Some(n) = node {
            let current_depth = depth + 1;
            map.insert(n.val, current_depth);
            dfs(&n.left, node, current_depth, map);
            dfs(&n.right, node, current_depth, map);
        }
    }

    let mut map = HashMap::new();
    dfs(&root, &None, 0, &mut map);

    let mut max_time = 0;
    let mut queue = VecDeque::new();

    if let Some(root_node) = root {
        queue.push_back((root_node.val, 0, None));
    }

    while let Some((node_val, time, parent)) = queue.pop_front() {
        max_time = std::cmp::max(max_time, time);
        if let Some(node) = root {
            if let Some(left) = node.left {
                if left.val != parent.unwrap_or_default().val {
                    queue.push_back((left.val, time + 1, Some(node)));
                }
            }
            if let Some(right) = node.right {
                if right.val != parent.unwrap_or_default().val {
                    queue.push_back((right.val, time + 1, Some(node)));
                }
            }
        }
    }

    max_time
}
}