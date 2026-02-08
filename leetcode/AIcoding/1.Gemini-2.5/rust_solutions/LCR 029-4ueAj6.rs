use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn insert(head: Option<Rc<RefCell<Node>>>, val: i32) -> Option<Rc<RefCell<Node>>> {
        // Case 1: Empty list
        if head.is_none() {
            let new_node = Rc::new(RefCell::new(Node::new(val)));
            new_node.borrow_mut().next = Some(Rc::clone(&new_node));
            return Some(new_node);
        }

        // Case 2: Non-empty list
        let head_rc = head.unwrap();
        let mut current_rc = Rc::clone(&head_rc);

        loop {
            let next_rc = Rc::clone(current_rc.borrow().next.as_ref().unwrap());

            let current_val = current_rc.borrow().val;
            let next_val = next_rc.borrow().val;

            // Condition 1: Normal insertion point
            // current_val <= val <= next_val
            if current_val <= val && val <= next_val {
                break;
            }

            // Condition 2: Insertion at the "wrap-around" point (new min or new max)
            // This handles cases where `val` is smaller than the smallest or larger than the largest.
            // e.g., list: 3 -> 5 -> 1 (current=5, next=1), val=6 (insert after 5)
            // e.g., list: 3 -> 5 -> 1 (current=5, next=1), val=0 (insert before 1)
            if current_val > next_val && (val >= current_val || val <= next_val) {
                break;
            }

            // Move to the next node
            current_rc = next_rc;

            // If we've completed a full cycle and haven't found an insertion point,
            // it means all elements are identical, or `val` doesn't fit any of the
            // strict sorted conditions. In this case, any position is fine; we break
            // and insert after the current node (which will be the head if we've looped).
            if Rc::ptr_eq(&current_rc, &head_rc) {
                break;
            }
        }

        // Insert the new node
        let new_node = Rc::new(RefCell::new(Node::new(val)));
        let old_next_rc = current_rc.borrow_mut().next.take().unwrap();
        new_node.borrow_mut().next = Some(old_next_rc);
        current_rc.borrow_mut().next = Some(new_node);

        Some(head_rc)
    }
}