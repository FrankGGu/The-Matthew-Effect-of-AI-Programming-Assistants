#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  fn new(val: i32) -> Self {
    ListNode {
      val: val,
      next: None
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
      val: val,
      left: None,
      right: None
    }
  }
}

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sorted_list_to_bst(head: Option<Box<ListNode>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut vec = Vec::new();
        let mut current = head;
        while let Some(node) = current {
            vec.push(node.val);
            current = node.next;
        }

        fn build_tree(arr: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
            if arr.is_empty() {
                return None;
            }
            let mid = arr.len() / 2;
            let root_val = arr[mid];
            let left_arr = &arr[..mid];
            let right_arr = &arr[mid + 1..];

            let root = Rc::new(RefCell::new(TreeNode::new(root_val)));
            root.borrow_mut().left = build_tree(left_arr);
            root.borrow_mut().right = build_tree(right_arr);

            Some(root)
        }

        build_tree(&vec)
    }
}

struct Solution;