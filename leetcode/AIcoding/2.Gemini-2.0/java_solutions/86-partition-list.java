class Solution {
    public ListNode partition(ListNode head, int x) {
        ListNode lessHead = new ListNode(0);
        ListNode greaterHead = new ListNode(0);
        ListNode lessTail = lessHead;
        ListNode greaterTail = greaterHead;

        while (head != null) {
            if (head.val < x) {
                lessTail.next = head;
                lessTail = head;
            } else {
                greaterTail.next = head;
                greaterTail = head;
            }
            head = head.next;
        }

        greaterTail.next = null;
        lessTail.next = greaterHead.next;

        return lessHead.next;
    }
}