use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn construct_from_pre_post(pre: Vec<i32>, post: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::helper(&pre, &post)
    }

    fn helper(pre: &[i32], post: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if pre.is_empty() {
            return None;
        }
        let root_val = pre[0];
        let mut root = TreeNode::new(root_val);
        if pre.len() == 1 {
            return Some(Rc::new(RefCell::new(root)));
        }
        let left_val = pre[1];
        let left_post_pos = post.iter().position(|&x| x == left_val).unwrap();
        let left_size = left_post_pos + 1;
        root.left = Self::helper(&pre[1..1 + left_size], &post[0..left_size]);
        root.right = Self::helper(&pre[1 + left_size..], &post[left_size..post.len() - 1]);
        Some(Rc::new(RefCell::new(root)))
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