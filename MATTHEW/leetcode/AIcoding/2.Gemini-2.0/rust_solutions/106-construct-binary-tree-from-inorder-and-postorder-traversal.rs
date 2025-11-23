use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn build_tree(inorder: Vec<i32>, postorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        fn build(
            inorder: &[i32],
            postorder: &[i32],
            in_start: usize,
            in_end: usize,
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

            root.borrow_mut().left = build(
                inorder,
                postorder,
                in_start,
                root_index - 1,
                post_start,
                post_start + (root_index - in_start) - 1,
            );
            root.borrow_mut().right = build(
                inorder,
                postorder,
                root_index + 1,
                in_end,
                post_start + (root_index - in_start),
                post_end - 1,
            );

            Some(root)
        }

        if inorder.is_empty() || postorder.is_empty() {
            return None;
        }

        build(
            &inorder,
            &postorder,
            0,
            inorder.len() - 1,
            0,
            postorder.len() - 1,
        )
    }
}

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

struct Solution;