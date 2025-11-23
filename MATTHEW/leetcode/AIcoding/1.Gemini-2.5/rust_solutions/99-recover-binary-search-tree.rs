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
    pub fn recover_tree(root: &mut Option<Rc<RefCell<TreeNode>>>) {
        let mut first_node: Option<Rc<RefCell<TreeNode>>> = None;
        let mut second_node: Option<Rc<RefCell<TreeNode>>> = None;
        let mut prev_node: Option<Rc<RefCell<TreeNode>>> = None;

        fn inorder_traverse(
            node_opt: Option<Rc<RefCell<TreeNode>>>,
            first: &mut Option<Rc<RefCell<TreeNode>>>,
            second: &mut Option<Rc<RefCell<TreeNode>>>,
            prev: &mut Option<Rc<RefCell<TreeNode>>>,
        ) {
            if let Some(node_rc) = node_opt {
                let current_node_val = node_rc.borrow().val;

                let left_child = node_rc.borrow().left.clone();
                inorder_traverse(left_child, first, second, prev);

                if let Some(p_node_rc) = prev.clone() {
                    if p_node_rc.borrow().val > current_node_val {
                        if first.is_none() {
                            *first = prev.clone();
                        }
                        *second = Some(node_rc.clone());
                    }
                }
                *prev = Some(node_rc.clone());

                let right_child = node_rc.borrow().right.clone();
                inorder_traverse(right_child, first, second, prev);
            }
        }

        inorder_traverse(root.clone(), &mut first_node, &mut second_node, &mut prev_node);

        if let (Some(f_node_rc), Some(s_node_rc)) = (first_node, second_node) {
            let mut f_node = f_node_rc.borrow_mut();
            let mut s_node = s_node_rc.borrow_mut();
            std::mem::swap(&mut f_node.val, &mut s_node.val);
        }
    }
}