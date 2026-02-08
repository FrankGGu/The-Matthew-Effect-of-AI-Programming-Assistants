class Solution {
    public ListNode doubleIt(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode curr = head;
        int carry = 0;

        while (curr != null) {
            int doubledVal = curr.val * 2 + carry;
            curr.val = doubledVal % 10;
            carry = doubledVal / 10;
            curr = curr.next;
        }

        if (carry > 0) {
            ListNode newHead = new ListNode(carry);
            newHead.next = dummy.next;
            return newHead;
        } else {
            return dummy.next;
        }
    }
}