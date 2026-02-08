use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn construct_from_pre_post(preorder: Vec<i32>, postorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        fn build(pre: &[i32], post: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
            if pre.is_empty() {
                return None;
            }

            let root_val = pre[0];
            let root = Rc::new(RefCell::new(TreeNode::new(root_val)));

            if pre.len() == 1 {
                return Some(root);
            }

            let left_val = pre[1];
            let left_size = post.iter().position(|&x| x == left_val).unwrap() + 1;

            root.borrow_mut().left = build(&pre[1..left_size + 1], &post[..left_size]);
            root.borrow_mut().right = build(&pre[left_size + 1..], &post[left_size..post.len() - 1]);

            Some(root)
        }

        build(&preorder, &postorder)
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
      right: None
    }
  }
}

struct Solution;