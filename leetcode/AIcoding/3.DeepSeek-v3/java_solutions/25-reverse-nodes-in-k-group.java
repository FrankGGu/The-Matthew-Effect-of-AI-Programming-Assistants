class Solution {
    public ListNode reverseKGroup(ListNode head, int k) {
        if (head == null || k == 1) {
            return head;
        }

        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        ListNode curr = head;
        int count = 0;

        while (curr != null) {
            count++;
            curr = curr.next;
        }

        curr = head;

        while (count >= k) {
            ListNode first = curr;
            ListNode prevGroupEnd = prev;

            for (int i = 0; i < k; i++) {
                ListNode next = curr.next;
                curr.next = prev;
                prev = curr;
                curr = next;
            }

            prevGroupEnd.next = prev;
            first.next = curr;
            prev = first;
            count -= k;
        }

        return dummy.next;
    }
}