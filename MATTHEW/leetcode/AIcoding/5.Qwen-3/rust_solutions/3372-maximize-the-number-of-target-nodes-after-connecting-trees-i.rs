impl Solution {

use std::collections::{HashSet, VecDeque};

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

pub fn connect_trees(root1: Option<Box<TreeNode>>, root2: Option<Box<TreeNode>>) -> i32 {
    fn get_nodes(root: Option<Box<TreeNode>>) -> HashSet<i32> {
        let mut set = HashSet::new();
        let mut queue = VecDeque::new();
        if let Some(node) = root {
            queue.push_back(node);
        }
        while let Some(node) = queue.pop_front() {
            set.insert(node.val);
            if let Some(left) = node.left {
                queue.push_back(left);
            }
            if let Some(right) = node.right {
                queue.push_back(right);
            }
        }
        set
    }

    let set1 = get_nodes(root1);
    let set2 = get_nodes(root2);

    let mut count = 0;
    for val in set1 {
        if set2.contains(&val) {
            count += 1;
        }
    }

    count
}
}