class Solution {
    public ListNode deleteMiddle(ListNode head) {
        if (head == null || head.next == null) {
            return null;
        }

        ListNode prevSlow = null;
        ListNode slow = head;
        ListNode fast = head;

        while (fast != null && fast.next != null) {
            prevSlow = slow;
            slow = slow.next;
            fast = fast.next.next;
        }

        // At this point, 'slow' is the middle node, and 'prevSlow' is the node before it.
        // 'prevSlow' will not be null because we handled the cases of 0 or 1 node initially.
        // For a list of 2 nodes (e.g., 1->2), prevSlow will be 1, slow will be 2.
        // For a list of 3 nodes (e.g., 1->2->3), prevSlow will be 1, slow will be 2.
        prevSlow.next = slow.next;

        return head;
    }
}