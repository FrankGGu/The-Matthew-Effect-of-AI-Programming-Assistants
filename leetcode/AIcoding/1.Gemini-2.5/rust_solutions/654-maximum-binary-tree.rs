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
    pub fn construct_maximum_binary_tree(nums: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::build_tree_recursive(&nums)
    }

    fn build_tree_recursive(nums_slice: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if nums_slice.is_empty() {
            return None;
        }

        let mut max_val = -1;
        let mut max_idx = 0;
        for (i, &val) in nums_slice.iter().enumerate() {
            if val > max_val {
                max_val = val;
                max_idx = i;
            }
        }

        let root = Rc::new(RefCell::new(TreeNode::new(max_val)));

        root.borrow_mut().left = Self::build_tree_recursive(&nums_slice[0..max_idx]);
        root.borrow_mut().right = Self::build_tree_recursive(&nums_slice[max_idx + 1..]);

        Some(root)
    }
}