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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn recover_from_preorder(traversal: String) -> Option<Rc<RefCell<TreeNode>>> {
        fn helper(traversal: &String, index: &mut usize, depth: i32) -> Option<Rc<RefCell<TreeNode>>> {
            let mut dashes = 0;
            while *index < traversal.len() && traversal.chars().nth(*index).unwrap() == '-' {
                dashes += 1;
                *index += 1;
            }

            if dashes != depth {
                *index -= dashes;
                return None;
            }

            let mut num_str = String::new();
            while *index < traversal.len() && traversal.chars().nth(*index).unwrap().is_digit(10) {
                num_str.push(traversal.chars().nth(*index).unwrap());
                *index += 1;
            }

            let val = num_str.parse::<i32>().unwrap();
            let node = Rc::new(RefCell::new(TreeNode::new(val)));

            node.borrow_mut().left = helper(traversal, index, depth + 1);
            node.borrow_mut().right = helper(traversal, index, depth + 1);

            Some(node)
        }

        let mut index = 0;
        helper(&traversal, &mut index, 0)
    }
}