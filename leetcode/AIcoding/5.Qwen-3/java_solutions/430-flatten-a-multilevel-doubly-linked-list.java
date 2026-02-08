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

                Node tail = getTail(child);
                tail.next = nextNode;

                if (nextNode != null) {
                    nextNode.prev = tail;
                }

                current = child;
            } else {
                current = current.next;
            }
        }

        return head;
    }

    private Node getTail(Node node) {
        while (node.next != null) {
            node = node.next;
        }
        return node;
    }

    static class Node {
        public int val;
        public Node prev;
        public Node next;
        public Node child;

        public Node() {}

        public Node(int val) {
            this.val = val;
        }

        public Node(int val, Node prev, Node next, Node child) {
            this.val = val;
            this.prev = prev;
            this.next = next;
            this.child = child;
        }
    }
}