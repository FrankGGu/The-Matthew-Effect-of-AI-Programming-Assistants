public class Solution {
    public ListNode doubleIt(ListNode head) {
        if (head == null) return null;

        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode current = dummy;

        while (current != null) {
            current.val *= 2;
            if (current.next != null && current.next.val >= 5) {
                current.val += 1;
            }
            current = current.next;
        }

        return dummy.val == 0 ? dummy.next : dummy;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode() {}
        ListNode(int val) { this.val = val; }
        ListNode(int val, ListNode next) { this.val = val; this.next = next; }
    }
}