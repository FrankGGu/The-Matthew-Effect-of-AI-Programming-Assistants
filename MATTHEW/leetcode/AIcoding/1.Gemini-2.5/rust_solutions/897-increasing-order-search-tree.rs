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
    fn inorder_collect(node: Option<Rc<RefCell<TreeNode>>>, nodes: &mut Vec<Rc<RefCell<TreeNode>>>) {
        if let Some(n_rc) = node {
            let n_ref = n_rc.borrow();
            Self::inorder_collect(n_ref.left.clone(), nodes);
            nodes.push(n_rc.clone());
            Self::inorder_collect(n_ref.right.clone(), nodes);
        }
    }

    pub fn increasing_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes_in_order: Vec<Rc<RefCell<TreeNode>>> = Vec::new();
        Self::inorder_collect(root, &mut nodes_in_order);

        if nodes_in_order.is_empty() {
            return None;
        }

        let dummy_head = Rc::new(RefCell::new(TreeNode::new(0)));
        let mut current_ptr = Rc::clone(&dummy_head);

        for node_rc in nodes_in_order {
            node_rc.borrow_mut().left = None;
            node_rc.borrow_mut().right = None;

            current_ptr.borrow_mut().right = Some(Rc::clone(&node_rc));
            current_ptr = Rc::clone(&node_rc);
        }

        dummy_head.borrow().right.clone()
    }
}