use std::collections::VecDeque;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn width_of_binary_tree(root: Option<Box<TreeNode>>) -> i32 {
        let mut max_width = 0;
        let mut queue = VecDeque::new();

        if let Some(node) = root {
            queue.push_back((node, 0));
        }

        while !queue.is_empty() {
            let level_length = queue.len();
            let (mut first_index, mut last_index) = (0, 0);

            for i in 0..level_length {
                let (node, index) = queue.pop_front().unwrap();
                if i == 0 {
                    first_index = index;
                }
                last_index = index;

                if let Some(left) = node.left {
                    queue.push_back((left, 2 * index));
                }
                if let Some(right) = node.right {
                    queue.push_back((right, 2 * index + 1));
                }
            }
            max_width = max_width.max(last_index - first_index + 1);
        }

        max_width
    }
}