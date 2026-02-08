class Solution {
    public ListNode reverseEvenLengthGroups(ListNode head) {
        ListNode dummy = new ListNode(0, head);
        ListNode prev = dummy;
        int groupSize = 1;

        while (prev.next != null) {
            ListNode start = prev.next;
            ListNode end = prev;
            int count = 0;

            for (int i = 0; i < groupSize && end.next != null; i++) {
                end = end.next;
                count++;
            }

            if (count % 2 == 0) {
                ListNode nextGroup = end.next;
                ListNode reversed = reverse(start, end);
                prev.next = reversed;
                start.next = nextGroup;
                prev = start;
            } else {
                prev = end;
            }

            groupSize++;
        }

        return dummy.next;
    }

    private ListNode reverse(ListNode start, ListNode end) {
        ListNode prev = null;
        ListNode curr = start;
        ListNode stop = end.next;

        while (curr != stop) {
            ListNode next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }

        return prev;
    }
}