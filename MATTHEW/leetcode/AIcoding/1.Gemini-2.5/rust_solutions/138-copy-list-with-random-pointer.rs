use std::rc::Rc;
use std::cell::RefCell;

pub struct Solution;

impl Solution {
    pub fn copy_random_list(head: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if head.is_none() {
            return None;
        }

        let mut current_opt = head.clone();

        // Step 1: Create new nodes and interleave them with original nodes.
        // Original: A -> B -> C
        // Interleaved: A -> A' -> B -> B' -> C -> C'
        while let Some(current_rc) = current_opt.clone() {
            let mut current_node = current_rc.borrow_mut();

            let next_original = current_node.next.take(); // Temporarily take original next

            let new_node_rc = Rc::new(RefCell::new(Node::new(current_node.val)));
            new_node_rc.borrow_mut().next = next_original.clone(); // New node's next points to original's next

            current_node.next = Some(new_node_rc); // Original node's next points to the new node

            current_opt = next_original; // Move to the next original node
        }

        // Step 2: Set random pointers for the new nodes.
        // If original.random points to X, then new_node.random points to X' (which is X.next).
        current_opt = head.clone();
        while let Some(current_rc) = current_opt.clone() {
            let current_node = current_rc.borrow(); // Borrow immutably to read next and random

            if let Some(new_node_rc) = current_node.next.clone() { // This is A'
                let mut new_node = new_node_rc.borrow_mut();

                if let Some(random_original_rc) = current_node.random.clone() { // This is X
                    // X' is X.next
                    new_node.random = random_original_rc.borrow().next.clone();
                }
            }

            // Move to the next original node (A -> A' -> B -> B')
            // current_node.next is A'. A'.borrow().next is B.
            current_opt = current_node.next.clone().and_then(|node_rc| node_rc.borrow().next.clone());
        }

        // Step 3: Separate the original list from the new list.
        // Restore original list's next pointers.
        // Link new list's next pointers.
        let new_head_opt = head.clone().and_then(|node_rc| node_rc.borrow().next.clone());
        let mut current_original_opt = head.clone();

        while let Some(original_rc) = current_original_opt.clone() {
            let mut original_node = original_rc.borrow_mut();

            if let Some(new_rc) = original_node.next.clone() { // This is A'
                let mut new_node = new_rc.borrow_mut();

                original_node.next = new_node.next.take(); // A's next was B, now original A's next is B.

                // A'.next should point to B'
                new_node.next = original_node.next.clone().and_then(|next_original_rc| next_original_rc.borrow().next.clone());
            }

            current_original_opt = original_node.next.clone(); // Move to B
        }

        new_head_opt
    }
}