class Solution {
    public Node flatten(Node head) {
        if (head == null) {
            return null;
        }
        flattenDFS(head);
        return head;
    }

    private Node flattenDFS(Node curr) {
        Node tail = curr; 
        while (curr != null) {
            if (curr.child != null) {
                Node nextNode = curr.next; 

                Node childHead = curr.child;
                Node childTail = flattenDFS(childHead); 

                curr.next = childHead;
                childHead.prev = curr;

                childTail.next = nextNode;
                if (nextNode != null) {
                    nextNode.prev = childTail;
                }

                curr.child = null; 

                tail = childTail; 
                curr = nextNode; 
            } else {
                tail = curr; 
                curr = curr.next; 
            }
        }
        return tail; 
    }
}