class Solution {
    public ListNode rotateRight(ListNode head, int k) {
        if (head == null || head.next == null || k == 0) {
            return head;
        }

        ListNode current = head;
        int length = 1;
        while (current.next != null) {
            current = current.next;
            length++;
        }

        current.next = head;
        k = k % length;
        k = length - k;

        ListNode tail = current;
        current = head;

        for (int i = 0; i < k; i++) {
            tail = current;
            current = current.next;
        }

        tail.next = null;
        head = current;

        return head;
    }
}