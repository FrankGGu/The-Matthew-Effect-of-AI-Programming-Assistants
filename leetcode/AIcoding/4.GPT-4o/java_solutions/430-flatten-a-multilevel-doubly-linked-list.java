class Node {
    public int val;
    public Node prev;
    public Node next;
    public Node child;

    public Node() {}

    public Node(int _val, Node _prev, Node _next, Node _child) {
        val = _val;
        prev = _prev;
        next = _next;
        child = _child;
    }
}

public class Solution {
    public Node flatten(Node head) {
        if (head == null) return null;
        Node dummy = new Node(0, null, head, null);
        Node prev = dummy;
        flattenHelper(head, prev);
        dummy.next.prev = null; // detach the dummy node
        return dummy.next;
    }

    private Node flattenHelper(Node curr, Node prev) {
        while (curr != null) {
            prev.next = curr;
            curr.prev = prev;
            Node tempNext = curr.next;
            if (curr.child != null) {
                Node childLast = flattenHelper(curr.child, curr);
                curr.child = null;
                curr.next = tempNext;
                if (tempNext != null) {
                    tempNext.prev = childLast;
                }
                return childLast;
            }
            prev = curr;
            curr = tempNext;
        }
        return prev;
    }
}