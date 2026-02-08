public class Solution {
    public ListNode rotateRight(ListNode head, int n) {
        if (head == null || n == 0) {
            return head;
        }

        int length = 1;
        ListNode tail = head;

        while (tail.next != null) {
            tail = tail.next;
            length++;
        }

        int k = n % length;
        if (k == 0) {
            return head;
        }

        int stepsToNewHead = length - k - 1;
        ListNode current = head;

        for (int i = 0; i < stepsToNewHead; i++) {
            current = current.next;
        }

        ListNode newHead = current.next;
        current.next = null;
        tail.next = head;

        return newHead;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}