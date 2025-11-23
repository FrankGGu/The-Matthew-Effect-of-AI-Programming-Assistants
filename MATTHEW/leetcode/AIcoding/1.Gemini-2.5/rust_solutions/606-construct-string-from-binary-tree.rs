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

struct Solution;

impl Solution {
    pub fn tree2str(root: Option<Rc<RefCell<TreeNode>>>) -> String {
        if let Some(node_rc) = root {
            let node = node_rc.borrow();
            let mut s = node.val.to_string();

            let left_str = Solution::tree2str(node.left.clone());
            let right_str = Solution::tree2str(node.right.clone());

            if left_str.is_empty() && right_str.is_empty() {
                // No children, just the value, s is already set
            } else if left_str.is_empty() && !right_str.is_empty() {
                // Has right child but no left child, left child must be represented by "()"
                s.push_str("()");
                s.push('(');
                s.push_str(&right_str);
                s.push(')');
            } else if !left_str.is_empty() && right_str.is_empty() {
                // Has left child but no right child
                s.push('(');
                s.push_str(&left_str);
                s.push(')');
            } else { // Both children exist
                s.push('(');
                s.push_str(&left_str);
                s.push(')');
                s.push('(');
                s.push_str(&right_str);
                s.push(')');
            }
            s
        } else {
            String::new()
        }
    }
}