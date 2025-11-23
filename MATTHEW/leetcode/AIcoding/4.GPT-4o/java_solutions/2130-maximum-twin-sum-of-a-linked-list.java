class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public int pairSum(ListNode head) {
        ListNode slow = head, fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        ListNode prev = null;
        while (slow != null) {
            ListNode nextNode = slow.next;
            slow.next = prev;
            prev = slow;
            slow = nextNode;
        }

        int maxTwinSum = 0;
        ListNode left = head;
        ListNode right = prev;

        while (right != null) {
            maxTwinSum = Math.max(maxTwinSum, left.val + right.val);
            left = left.next;
            right = right.next;
        }

        return maxTwinSum;
    }
}