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

type Node = Option<Rc<RefCell<TreeNode>>>;

impl Solution {
    fn is_same_tree(p: &Node, q: &Node) -> bool {
        match (p, q) {
            (None, None) => true,
            (Some(p_node), Some(q_node)) => {
                let p_ref = p_node.borrow();
                let q_ref = q_node.borrow();
                p_ref.val == q_ref.val
                    && Self::is_same_tree(&p_ref.left, &q_ref.left)
                    && Self::is_same_tree(&p_ref.right, &q_ref.right)
            }
            _ => false,
        }
    }

    pub fn is_subtree(root: Node, sub_root: Node) -> bool {
        if root.is_none() {
            return false;
        }

        if Self::is_same_tree(&root, &sub_root) {
            return true;
        }

        let root_node = root.as_ref().unwrap().borrow();
        Self::is_subtree(root_node.left.clone(), sub_root.clone())
            || Self::is_subtree(root_node.right.clone(), sub_root.clone())
    }
}