#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn build_tree(inorder: Vec<i32>, postorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        if inorder.is_empty() || postorder.is_empty() {
            return None;
        }

        let n = inorder.len();
        Self::build_tree_helper(&inorder, 0, n - 1, &postorder, 0, n - 1)
    }

    fn build_tree_helper(
        inorder: &Vec<i32>,
        in_start: usize,
        in_end: usize,
        postorder: &Vec<i32>,
        post_start: usize,
        post_end: usize,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if in_start > in_end || post_start > post_end {
            return None;
        }

        let root_val = postorder[post_end];
        let root = Rc::new(RefCell::new(TreeNode::new(root_val)));

        let mut root_index = 0;
        for i in in_start..=in_end {
            if inorder[i] == root_val {
                root_index = i;
                break;
            }
        }

        let left_size = root_index - in_start;

        root.borrow_mut().left = Self::build_tree_helper(
            inorder,
            in_start,
            root_index - 1,
            postorder,
            post_start,
            post_start + left_size - 1,
        );

        root.borrow_mut().right = Self::build_tree_helper(
            inorder,
            root_index + 1,
            in_end,
            postorder,
            post_start + left_size,
            post_end - 1,
        );

        Some(root)
    }
}

struct Solution;