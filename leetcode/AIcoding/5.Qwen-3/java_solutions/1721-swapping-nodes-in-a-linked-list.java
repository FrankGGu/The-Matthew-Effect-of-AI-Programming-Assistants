public class Solution {
    public ListNode swapNodes(ListNode head, int k) {
        ListNode first = head;
        for (int i = 0; i < k - 1; i++) {
            first = first.next;
        }

        ListNode second = head;
        ListNode tail = first;
        while (tail.next != null) {
            second = second.next;
            tail = tail.next;
        }

        int temp = first.val;
        first.val = second.val;
        second.val = temp;

        return head;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode() {}
        ListNode(int val) { this.val = val; }
        ListNode(int val, ListNode next) { this.val = val; this.next = next; }
    }
}