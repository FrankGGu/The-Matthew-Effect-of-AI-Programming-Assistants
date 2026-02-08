public class Solution {
    public Node insert(Node head, int insertVal) {
        if (head == null) {
            Node node = new Node(insertVal);
            node.next = node;
            return node;
        }

        Node curr = head;
        Node next = head.next;
        boolean found = false;

        while (true) {
            if (curr.val <= insertVal && insertVal <= next.val) {
                found = true;
                break;
            } else if (curr.val > next.val) {
                if (insertVal >= curr.val || insertVal <= next.val) {
                    found = true;
                    break;
                }
            }

            curr = next;
            next = next.next;

            if (curr == head) {
                break;
            }
        }

        if (!found) {
            curr.next = new Node(insertVal, next);
        } else {
            curr.next = new Node(insertVal, next);
        }

        return head;
    }

    static class Node {
        public int val;
        public Node next;

        public Node() {}

        public Node(int val) {
            this.val = val;
        }

        public Node(int val, Node next) {
            this.val = val;
            this.next = next;
        }
    }
}