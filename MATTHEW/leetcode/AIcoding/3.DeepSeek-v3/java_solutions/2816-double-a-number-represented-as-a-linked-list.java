class Solution {
    public ListNode doubleIt(ListNode head) {
        ListNode reversed = reverse(head);
        ListNode dummy = new ListNode(0);
        ListNode current = dummy;
        int carry = 0;

        while (reversed != null || carry != 0) {
            int sum = carry;
            if (reversed != null) {
                sum += reversed.val * 2;
                reversed = reversed.next;
            }
            carry = sum / 10;
            current.next = new ListNode(sum % 10);
            current = current.next;
        }

        return reverse(dummy.next);
    }

    private ListNode reverse(ListNode head) {
        ListNode prev = null;
        ListNode current = head;
        while (current != null) {
            ListNode next = current.next;
            current.next = prev;
            prev = current;
            current = next;
        }
        return prev;
    }
}