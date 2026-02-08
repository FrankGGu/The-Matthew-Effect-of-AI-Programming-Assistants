use std::rc::Rc;
use std::cell::RefCell;

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

impl Solution {
    pub fn is_sub_path(head: Option<Box<ListNode>>, root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return false;
        }

        if Solution::check(&head, &root) {
            return true;
        }

        let root_ref = root.as_ref().unwrap().borrow();
        Solution::is_sub_path(head.clone(), root_ref.left.clone()) ||
        Solution::is_sub_path(head, root_ref.right.clone())
    }

    fn check(list_node: &Option<Box<ListNode>>, tree_node: &Option<Rc<RefCell<TreeNode>>>) -> bool {
        if list_node.is_none() {
            return true;
        }
        if tree_node.is_none() {
            return false;
        }

        let list_val = list_node.as_ref().unwrap().val;
        let tree_val = tree_node.as_ref().unwrap().borrow().val;

        if list_val != tree_val {
            return false;
        }

        let next_list_node = &list_node.as_ref().unwrap().next;
        let tree_node_ref = tree_node.as_ref().unwrap().borrow();

        Solution::check(next_list_node, &tree_node_ref.left) ||
        Solution::check(next_list_node, &tree_node_ref.right)
    }
}