use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
  pub val: i32,
  pub left: Option<Rc<RefCell<Node>>>,
  pub right: Option<Rc<RefCell<Node>>>,
  pub next: Option<Rc<RefCell<Node>>>,
}

impl Node {
  #[inline]
  pub fn new(val: i32) -> Self {
    Node {
      val,
      left: None,
      right: None,
      next: None
    }
  }
}

impl Solution {
    pub fn connect(root: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if root.is_none() {
            return None;
        }

        let mut current_level_head = root.clone();

        while let Some(node_rc) = current_level_head.clone() {
            let mut curr_node_option = Some(Rc::clone(&node_rc));

            while let Some(curr_rc) = curr_node_option {
                let mut curr = curr_rc.borrow_mut();

                if let (Some(left_child_rc), Some(right_child_rc)) = (curr.left.as_ref(), curr.right.as_ref()) {
                    // Connect left child to right child
                    left_child_rc.borrow_mut().next = Some(Rc::clone(right_child_rc));

                    // Connect right child to the left child of the next node (if next exists)
                    if let Some(next_node_rc) = curr.next.as_ref() {
                        // In a perfect binary tree, if curr.next exists, then next_node_rc.borrow().left will also exist.
                        if let Some(next_node_left_child_rc) = next_node_rc.borrow().left.as_ref() {
                            right_child_rc.borrow_mut().next = Some(Rc::clone(next_node_left_child_rc));
                        }
                    }
                } else {
                    // If curr has no children, it means we are at the leaf level.
                    // Since it's a perfect binary tree, all nodes at this level are leaves.
                    // No further connections needed for this level or below.
                    // The outer loop will terminate after this level.
                }

                // Move to the next node in the current level using its 'next' pointer
                curr_node_option = curr.next.clone();
            }

            // After processing all nodes in the current level, move `current_level_head`
            // to the first child of the first node of the current level.
            current_level_head = node_rc.borrow().left.clone();
        }

        root
    }
}