class Solution {
    public ListNode reverseKGroup(ListNode head, int k) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode pre = dummy;
        ListNode cur = head;

        while (cur != null) {
            ListNode tail = pre;
            for (int i = 0; i < k; i++) {
                tail = tail.next;
                if (tail == null) {
                    return dummy.next;
                }
            }

            ListNode nextGroup = tail.next;
            ListNode[] reversed = reverse(cur, tail);
            cur = reversed[0];
            tail = reversed[1];

            pre.next = cur;
            tail.next = nextGroup;

            pre = tail;
            cur = nextGroup;
        }

        return dummy.next;
    }

    private ListNode[] reverse(ListNode head, ListNode tail) {
        ListNode prev = tail.next;
        ListNode curr = head;

        while (prev != tail) {
            ListNode next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }

        return new ListNode[]{tail, head};
    }
}