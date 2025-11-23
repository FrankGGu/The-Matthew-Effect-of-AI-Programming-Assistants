use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn build_tree(preorder: Vec<i32>, inorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        fn build(preorder: &[i32], inorder: &[i32], pre_start: usize, in_start: usize, in_end: usize) -> Option<Rc<RefCell<TreeNode>>> {
            if pre_start >= preorder.len() || in_start > in_end {
                return None;
            }

            let root_val = preorder[pre_start];
            let mut root_index = 0;
            for i in in_start..=in_end {
                if inorder[i] == root_val {
                    root_index = i;
                    break;
                }
            }

            let left_size = root_index - in_start;

            let root = Rc::new(RefCell::new(TreeNode {
                val: root_val,
                left: build(preorder, inorder, pre_start + 1, in_start, root_index - 1),
                right: build(preorder, inorder, pre_start + left_size + 1, root_index + 1, in_end),
            }));

            Some(root)
        }

        build(&preorder, &inorder, 0, 0, inorder.len() - 1)
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