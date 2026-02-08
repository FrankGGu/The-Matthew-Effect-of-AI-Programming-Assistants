use std::rc::Rc;
use std::cell::RefCell;

struct Solution;

impl Solution {
    pub fn copy_random_list(head: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if head.is_none() {
            return None;
        }

        let mut current = head.clone();

        // Step 1: Create new nodes and interleave them with original nodes.
        // Original: A -> B -> C
        // Modified: A -> A' -> B -> B' -> C -> C'
        while let Some(node_rc) = current.clone() {
            let mut node = node_rc.borrow_mut();
            let new_node_rc = Rc::new(RefCell::new(Node::new(node.val)));

            // Link new_node_rc to original's next
            new_node_rc.borrow_mut().next = node.next.take();
            // Link original to new_node_rc
            node.next = Some(new_node_rc);

            // Move current to the next original node (which is new_node_rc.next)
            current = node.next.clone().unwrap().borrow().next.clone();
        }

        // Reset current to head for the second pass.
        current = head.clone();

        // Step 2: Assign random pointers for the new nodes.
        // If an original node A has random pointer to B, then its copy A' should have random pointer to B'.
        // A' is A.next, B' is B.next.
        while let Some(node_rc) = current.clone() {
            let node = node_rc.borrow();
            if let Some(ref random_rc) = node.random {
                let new_node_rc = node.next.clone().unwrap(); // This is A'
                let random_copy_rc = random_rc.borrow().next.clone().unwrap(); // This is B' (which is B.next)
                new_node_rc.borrow_mut().random = Some(random_copy_rc);
            }
            // Move current to the next original node
            current = node.next.clone().unwrap().borrow().next.clone();
        }

        // Step 3: Separate the original and new lists.
        let mut original_current = head.clone();
        let new_head = head.as_ref().unwrap().borrow().next.clone(); // The head of the new list is head.next

        while let Some(original_node_rc) = original_current.clone() {
            let mut original_node = original_node_rc.borrow_mut();
            let new_node_rc = original_node.next.take().unwrap(); // Take A' from A.next

            // Restore original_node's next pointer
            original_node.next = new_node_rc.borrow().next.clone(); // A.next becomes B

            // Set new_node_rc's next pointer
            if let Some(next_original_node_rc) = original_node.next.clone() {
                // If there's a next original node (B), then A'.next should be B'
                new_node_rc.borrow_mut().next = next_original_node_rc.borrow().next.clone();
            } else {
                // If A was the last original node, A'.next should be None
                new_node_rc.borrow_mut().next = None;
            }

            // Move to the next original node
            original_current = original_node.next.clone();
        }

        new_head
    }
}