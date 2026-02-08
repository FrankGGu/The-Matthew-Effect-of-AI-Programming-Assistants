public class Solution {
    public int pairSum(ListNode head) {
        ListNode slow = head;
        ListNode fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        ListNode prev = null;
        ListNode curr = slow;
        while (curr != null) {
            ListNode next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }

        int maxSum = 0;
        ListNode left = head;
        ListNode right = prev;
        while (right != null) {
            maxSum = Math.max(maxSum, left.val + right.val);
            left = left.next;
            right = right.next;
        }

        return maxSum;
    }
}