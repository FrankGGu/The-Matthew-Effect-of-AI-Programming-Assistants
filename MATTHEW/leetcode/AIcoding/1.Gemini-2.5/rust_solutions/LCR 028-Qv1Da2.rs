use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn flatten(head: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if head.is_none() {
            return None;
        }

        let mut current_ptr = head.clone();

        while let Some(node_rc) = current_ptr.clone() {
            let next_node_rc_to_move_to; 

            {
                let mut node = node_rc.borrow_mut();

                if let Some(child_rc) = node.child.take() {
                    let original_next_rc = node.next.take();

                    node.next = Some(Rc::clone(&child_rc));
                    child_rc.borrow_mut().prev = Some(Rc::clone(&node_rc));

                    let mut child_tail_rc = Rc::clone(&child_rc);
                    loop {
                        let tail_node = child_tail_rc.borrow();
                        if let Some(next_in_child) = &tail_node.next {
                            child_tail_rc = Rc::clone(next_in_child);
                        } else {
                            break;
                        }
                    }

                    child_tail_rc.borrow_mut().next = original_next_rc.clone();
                    if let Some(ref next_rc) = original_next_rc {
                        next_rc.borrow_mut().prev = Some(Rc::clone(&child_tail_rc));
                    }

                    next_node_rc_to_move_to = Some(Rc::clone(&child_rc));
                } else {
                    next_node_rc_to_move_to = node.next.clone();
                }
            } 

            current_ptr = next_node_rc_to_move_to;
        }

        head
    }
}