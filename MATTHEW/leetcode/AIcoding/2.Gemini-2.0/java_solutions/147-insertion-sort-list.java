class Solution {
    public ListNode insertionSortList(ListNode head) {
        ListNode dummyHead = new ListNode(0);
        ListNode curr = head;

        while (curr != null) {
            ListNode prev = dummyHead;
            while (prev.next != null && prev.next.val < curr.val) {
                prev = prev.next;
            }

            ListNode nextNode = curr.next;
            curr.next = prev.next;
            prev.next = curr;
            curr = nextNode;
        }

        return dummyHead.next;
    }
}