impl Solution {
    pub fn is_valid_serialization(preorder: String) -> bool {
        let nodes: Vec<&str> = preorder.split(',').collect();
        let mut slots: i32 = 1; // Represents available slots for children

        for node in nodes {
            // If slots become 0, and we still have nodes to process,
            // it means we're trying to add a node where there's no parent slot.
            // This check must happen before processing the current node.
            // The only exception is the very first node where slots is 1 initially.
            // If slots is 0, it means the previous node consumed the last slot and didn't provide new ones,
            // or we've processed a complete subtree. If there are more elements, it's invalid.
            if slots == 0 {
                return false;
            }

            if node == "#" {
                slots -= 1; // A null node consumes one slot and provides none.
            } else {
                // A non-null node consumes one slot and provides two new slots.
                // Net effect: slots - 1 + 2 = slots + 1
                slots += 1;
            }
        }

        // After processing all nodes, a valid serialization should have exactly 0 slots remaining.
        // This means all nodes have found their parents and all child slots have been filled (either by a node or a '#').
        slots == 0
    }
}