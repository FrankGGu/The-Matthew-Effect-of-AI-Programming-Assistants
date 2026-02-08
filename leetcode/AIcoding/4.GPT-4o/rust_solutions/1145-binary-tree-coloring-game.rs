use std::collections::VecDeque;

struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct Solution;

impl Solution {
    pub fn btree_game_winning_move(root: Option<Box<TreeNode>>, n: i32, x: i32) -> bool {
        let (left_count, right_count) = Self::count_children(&root, x);
        let parent_count = n - left_count - right_count - 1;

        left_count > n / 2 || right_count > n / 2 || parent_count > n / 2
    }

    fn count_children(node: &Option<Box<TreeNode>>, x: i32) -> (i32, i32) {
        if node.is_none() {
            return (0, 0);
        }
        let node = node.as_ref().unwrap();
        let mut left = 0;
        let mut right = 0;

        if node.val == x {
            left = Self::count_nodes(&node.left);
            right = Self::count_nodes(&node.right);
        } else {
            let (l, r) = Self::count_children(&node.left, x);
            left += l;
            right += r;
            left += Self::count_nodes(&node.left);
            right += Self::count_nodes(&node.right);
        }

        (left, right)
    }

    fn count_nodes(node: &Option<Box<TreeNode>>) -> i32 {
        if node.is_none() {
            return 0;
        }
        let node = node.as_ref().unwrap();
        1 + Self::count_nodes(&node.left) + Self::count_nodes(&node.right)
    }
}