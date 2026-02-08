public class Solution {

class Node {
    public int val;
    public Node prev;
    public Node next;
    public Node child;
}

public class Solution {
    public Node flatten(Node head) {
        if (head == null) return null;

        Node current = head;

        while (current != null) {
            if (current.child != null) {
                Node nextNode = current.next;
                Node child = current.child;

                current.next = child;
                child.prev = current;
                current.child = null;

                Node tail = child;
                while (tail.next != null) {
                    tail = tail.next;
                }

                tail.next = nextNode;
                if (nextNode != null) {
                    nextNode.prev = tail;
                }
            }

            current = current.next;
        }

        return head;
    }
}
}