class Solution {
    public ListNode swapPairs(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        ListNode current = head;

        while (current != null && current.next != null) {
            ListNode firstNode = current;
            ListNode secondNode = current.next;

            prev.next = secondNode;
            firstNode.next = secondNode.next;
            secondNode.next = firstNode;

            prev = firstNode;
            current = firstNode.next;
        }

        return dummy.next;
    }
}