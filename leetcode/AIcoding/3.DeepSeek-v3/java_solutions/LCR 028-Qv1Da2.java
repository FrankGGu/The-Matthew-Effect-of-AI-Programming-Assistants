class Solution {
    public Node flatten(Node head) {
        if (head == null) return null;
        Node dummy = new Node(0, null, head, null);
        flattenDFS(dummy, head);
        dummy.next.prev = null;
        return dummy.next;
    }

    private Node flattenDFS(Node prev, Node curr) {
        if (curr == null) return prev;
        curr.prev = prev;
        prev.next = curr;
        Node next = curr.next;
        Node tail = flattenDFS(curr, curr.child);
        curr.child = null;
        return flattenDFS(tail, next);
    }
}