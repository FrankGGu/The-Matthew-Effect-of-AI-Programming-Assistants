class Solution {
    public Node flatten(Node head) {
        if (head == null) {
            return null;
        }

        flattenDFS(head);
        return head;
    }

    // This helper function flattens the list starting from 'node' and returns the tail of the flattened list segment.
    private Node flattenDFS(Node node) {
        Node curr = node;
        Node tail = node; // Keeps track of the tail of the current flattened segment

        while (curr != null) {
            // If the current node has a child, we need to flatten it
            if (curr.child != null) {
                Node nextNode = curr.next; // Save the next node in the main list

                // Recursively flatten the child list and get its tail
                Node childHead = curr.child;
                Node childTail = flattenDFS(childHead);

                // Connect the current node to the head of the flattened child list
                curr.next = childHead;
                childHead.prev = curr;
                curr.child = null; // Clear the child pointer as it's now flattened

                // Connect the tail of the flattened child list to the saved nextNode
                childTail.next = nextNode;
                if (nextNode != null) {
                    nextNode.prev = childTail;
                }

                // Move 'curr' to the tail of the just-inserted child list.
                // This ensures that the loop continues traversal from the correct point
                // (i.e., after the entire flattened child segment).
                curr = childTail; 
            }

            // Update the tail to the current node (this will be the tail if no more next nodes or children)
            tail = curr; 
            // Move to the next node in the flattened list
            curr = curr.next;
        }

        return tail; // Return the tail of the flattened list segment starting from 'node'
    }
}