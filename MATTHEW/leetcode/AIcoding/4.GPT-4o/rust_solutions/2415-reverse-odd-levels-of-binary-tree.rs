use crate::utils::TreeNode;
use std::collections::VecDeque;

pub fn reverse_odd_levels(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    if root.is_none() {
        return root;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root.clone());
    let mut level = 0;

    while !queue.is_empty() {
        let mut size = queue.len();
        let mut current_level = vec![];

        while size > 0 {
            if let Some(node) = queue.pop_front().unwrap() {
                current_level.push(node.clone());
                if let Some(left) = node.left.clone() {
                    queue.push_back(Some(left));
                }
                if let Some(right) = node.right.clone() {
                    queue.push_back(Some(right));
                }
            }
            size -= 1;
        }

        if level % 2 == 1 {
            let n = current_level.len();
            for i in 0..n / 2 {
                let temp = current_level[i].val;
                current_level[i].val = current_level[n - 1 - i].val;
                current_level[n - 1 - i].val = temp;
            }
        }

        level += 1;
    }

    root
}