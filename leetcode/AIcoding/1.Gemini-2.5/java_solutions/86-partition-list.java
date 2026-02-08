class Solution {
    public ListNode partition(ListNode head, int x) {
        ListNode lessHead = new ListNode(0);
        ListNode greaterEqualHead = new ListNode(0);

        ListNode lessPtr = lessHead;
        ListNode greaterEqualPtr = greaterEqualHead;

        ListNode current = head;
        while (current != null) {
            if (current.val < x) {
                lessPtr.next = current;
                lessPtr = lessPtr.next;
            } else {
                greaterEqualPtr.next = current;
                greaterEqualPtr = greaterEqualPtr.next;
            }
            current = current.next;
        }

        greaterEqualPtr.next = null;
        lessPtr.next = greaterEqualHead.next;

        return lessHead.next;
    }
}