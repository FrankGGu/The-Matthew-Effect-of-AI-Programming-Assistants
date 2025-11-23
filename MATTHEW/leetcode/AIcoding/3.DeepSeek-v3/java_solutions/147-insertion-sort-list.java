class Solution {
    public ListNode insertionSortList(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode dummy = new ListNode(0);
        ListNode prev = dummy;
        ListNode current = head;

        while (current != null) {
            ListNode next = current.next;

            while (prev.next != null && prev.next.val < current.val) {
                prev = prev.next;
            }

            current.next = prev.next;
            prev.next = current;
            prev = dummy;
            current = next;
        }

        return dummy.next;
    }
}