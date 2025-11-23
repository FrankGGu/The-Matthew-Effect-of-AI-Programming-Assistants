public class Solution {
    public ListNode mergeInBetween(ListNode head1, int v1, int v2) {
        ListNode dummy = new ListNode(0);
        dummy.next = head1;
        ListNode prev = dummy;
        ListNode curr = head1;

        while (curr.val != v1) {
            prev = curr;
            curr = curr.next;
        }

        ListNode end = curr;
        while (end.val != v2) {
            end = end.next;
        }

        prev.next = end.next;
        return dummy.next;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}