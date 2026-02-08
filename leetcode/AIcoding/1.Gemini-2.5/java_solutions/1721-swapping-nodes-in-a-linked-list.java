class Solution {
    public ListNode swapNodes(ListNode head, int k) {
        ListNode firstNode = head;
        for (int i = 1; i < k; i++) {
            firstNode = firstNode.next;
        }

        ListNode slow = head;
        ListNode fast = firstNode;

        while (fast.next != null) {
            slow = slow.next;
            fast = fast.next;
        }

        ListNode secondNode = slow;

        int temp = firstNode.val;
        firstNode.val = secondNode.val;
        secondNode.val = temp;

        return head;
    }
}