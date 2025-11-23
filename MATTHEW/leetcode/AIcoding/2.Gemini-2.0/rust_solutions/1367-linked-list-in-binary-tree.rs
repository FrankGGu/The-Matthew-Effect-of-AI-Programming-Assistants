#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  fn new(val: i32) -> Self {
    ListNode {
      next: None,
      val
    }
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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_sub_path(head: Option<Box<ListNode>>, root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return false;
        }

        let root_node = root.as_ref().unwrap().borrow();

        Self::is_sub_path_helper(head.clone(), Some(Rc::new(RefCell::new(TreeNode {
            val: root_node.val,
            left: root_node.left.clone(),
            right: root_node.right.clone()
        })))) || Self::is_sub_path(head.clone(), root_node.left.clone()) || Self::is_sub_path(head.clone(), root_node.right.clone())
    }

    fn is_sub_path_helper(head: Option<Box<ListNode>>, root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (head, root) {
            (None, _) => true,
            (_, None) => false,
            (Some(head_node), Some(root_node)) => {
                let root_val = root_node.borrow().val;
                let head_val = head_node.val;

                if root_val != head_val {
                    return false;
                }

                let next_head = head_node.next;
                let left_root = root_node.borrow().left.clone();
                let right_root = root_node.borrow().right.clone();

                Self::is_sub_path_helper(next_head.clone(), left_root) || Self::is_sub_path_helper(next_head, right_root)
            }
        }
    }
}

struct Solution;