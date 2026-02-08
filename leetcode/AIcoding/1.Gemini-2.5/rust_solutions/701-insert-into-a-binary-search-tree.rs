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
      right: None,
    }
  }
}
use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn insert_into_bst(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        let new_node = Rc::new(RefCell::new(TreeNode::new(val)));

        if root.is_none() {
            return Some(new_node);
        }

        let mut current_node_rc = root.clone();

        while let Some(node_rc) = current_node_rc.clone() {
            let mut node = node_rc.borrow_mut();

            if val < node.val {
                if node.left.is_none() {
                    node.left = Some(new_node.clone());
                    return root;
                } else {
                    current_node_rc = node.left.clone();
                }
            } else {
                if node.right.is_none() {
                    node.right = Some(new_node.clone());
                    return root;
                } else {
                    current_node_rc = node.right.clone();
                }
            }
        }
        root
    }
}