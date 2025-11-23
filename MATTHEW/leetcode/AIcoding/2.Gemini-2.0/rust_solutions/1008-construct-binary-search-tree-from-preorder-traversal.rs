use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn bst_from_preorder(preorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        fn helper(preorder: &Vec<i32>, index: &mut usize, bound: i32) -> Option<Rc<RefCell<TreeNode>>> {
            if *index == preorder.len() || preorder[*index] > bound {
                return None;
            }

            let val = preorder[*index];
            *index += 1;
            let root = Rc::new(RefCell::new(TreeNode::new(val)));
            root.borrow_mut().left = helper(preorder, index, val);
            root.borrow_mut().right = helper(preorder, index, bound);

            Some(root)
        }

        let mut index = 0;
        helper(&preorder, &mut index, i32::MAX)
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