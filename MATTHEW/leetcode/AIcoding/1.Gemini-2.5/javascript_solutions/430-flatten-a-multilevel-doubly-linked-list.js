var flatten = function(head) {
    if (!head) {
        return head;
    }

    let curr = head;

    while (curr) {
        if (curr.child) {
            // Save the next node in the current level
            let nextNode = curr.next;

            // Connect current node to its child list
            let childHead = curr.child;
            curr.next = childHead;
            childHead.prev = curr;
            curr.child = null; // Child is now flattened into the main list

            // Find the tail of the child list
            // This tail might itself have children, but the main loop will handle them
            // when it eventually reaches those nodes.
            let childTail = childHead;
            while (childTail.next) {
                childTail = childTail.next;
            }

            // Connect the tail of the child list to the original next node
            childTail.next = nextNode;
            if (nextNode) {
                nextNode.prev = childTail;
            }
        }
        // Move to the next node in the (possibly modified) list
        curr = curr.next;
    }

    return head;
};