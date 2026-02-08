class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode doubleIt(ListNode head) {
        ListNode dummy = new ListNode(0);
        ListNode curr = dummy, p = head;
        int carry = 0;

        while (p != null) {
            int sum = p.val * 2 + carry;
            carry = sum / 10;
            curr.next = new ListNode(sum % 10);
            curr = curr.next;
            p = p.next;
        }

        if (carry > 0) {
            curr.next = new ListNode(carry);
        }

        return reverse(dummy.next);
    }

    private ListNode reverse(ListNode head) {
        ListNode prev = null;
        while (head != null) {
            ListNode next = head.next;
            head.next = prev;
            prev = head;
            head = next;
        }
        return prev;
    }
}