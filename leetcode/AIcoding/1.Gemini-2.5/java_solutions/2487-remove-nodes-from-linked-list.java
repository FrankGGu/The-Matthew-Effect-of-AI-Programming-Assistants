class Solution {
    public ListNode removeNodes(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode nextGreaterListHead = removeNodes(head.next);

        if (head.val < nextGreaterListHead.val) {
            return nextGreaterListHead;
        } else {
            head.next = nextGreaterListHead;
            return head;
        }
    }
}