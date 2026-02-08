use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn btree_game_winning_move(root: Option<Rc<RefCell<TreeNode>>>, n: i32, x: i32) -> bool {
        let mut left_count = 0;
        let mut right_count = 0;

        Self::count_nodes(root.as_ref(), x, &mut left_count, &mut right_count);

        let parent_count = n - (left_count + right_count + 1);
        let max_count = parent_count.max(left_count.max(right_count));

        max_count > n / 2
    }

    fn count_nodes(
        node: Option<&Rc<RefCell<TreeNode>>>,
        x: i32,
        left_count: &mut i32,
        right_count: &mut i32,
    ) -> i32 {
        if node.is_none() {
            return 0;
        }

        let node = node.unwrap().borrow();
        let left = Self::count_nodes(node.left.as_ref(), x, left_count, right_count);
        let right = Self::count_nodes(node.right.as_ref(), x, left_count, right_count);

        if node.val == x {
            *left_count = left;
            *right_count = right;
        }

        left + right + 1
    }
}