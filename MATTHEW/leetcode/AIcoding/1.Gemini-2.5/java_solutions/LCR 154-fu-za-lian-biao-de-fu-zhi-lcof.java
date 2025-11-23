class Solution {
    public Node copyRandomList(Node head) {
        if (head == null) {
            return null;
        }

        Node current = head;
        while (current != null) {
            Node newNode = new Node(current.val);
            newNode.next = current.next;
            current.next = newNode;
            current = newNode.next;
        }

        current = head;
        while (current != null) {
            if (current.random != null) {
                current.next.random = current.random.next;
            }
            current = current.next.next;
        }

        Node originalHead = head;
        Node copiedHead = head.next;
        Node copiedCurrent = copiedHead;

        while (originalHead != null) {
            originalHead.next = copiedCurrent.next;
            originalHead = originalHead.next;

            if (originalHead != null) {
                copiedCurrent.next = originalHead.next;
            } else {
                copiedCurrent.next = null;
            }
            copiedCurrent = copiedCurrent.next;
        }

        return copiedHead;
    }
}