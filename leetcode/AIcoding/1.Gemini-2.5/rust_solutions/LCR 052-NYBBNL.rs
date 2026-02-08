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
    pub fn increasing_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut values = Vec::new();
        Self::inorder_collect(root, &mut values);

        let dummy_head = Rc::new(RefCell::new(TreeNode::new(0)));
        let mut current_node = Rc::clone(&dummy_head);

        for val in values {
            let new_node = Rc::new(RefCell::new(TreeNode::new(val)));
            current_node.borrow_mut().right = Some(Rc::clone(&new_node));
            current_node = Rc::clone(&new_node);
        }

        dummy_head.borrow().right.clone()
    }

    fn inorder_collect(node: Option<Rc<RefCell<TreeNode>>>, values: &mut Vec<i32>) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            Self::inorder_collect(n.left.clone(), values);
            values.push(n.val);
            Self::inorder_collect(n.right.clone(), values);
        }
    }
}