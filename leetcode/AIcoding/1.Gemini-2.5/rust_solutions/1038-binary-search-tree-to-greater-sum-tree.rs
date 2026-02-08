use std::rc::Rc;
use std::cell::RefCell;

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

impl Solution {
    pub fn bst_to_gst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut sum = 0;
        Self::dfs_reverse_inorder(&root, &mut sum);
        root
    }

    fn dfs_reverse_inorder(node_option: &Option<Rc<RefCell<TreeNode>>>, sum: &mut i32) {
        if let Some(node_rc) = node_option {
            let mut node = node_rc.borrow_mut();

            Self::dfs_reverse_inorder(&node.right, sum);

            node.val += *sum;
            *sum = node.val;

            Self::dfs_reverse_inorder(&node.left, sum);
        }
    }
}