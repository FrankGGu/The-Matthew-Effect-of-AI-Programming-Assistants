public class Solution {
    public void reorderList(ListNode head) {
        if (head == null || head.next == null) return;

        ListNode slow = head;
        ListNode fast = head;
        while (fast.next != null && fast.next.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        ListNode mid = slow;
        ListNode prev = null;
        ListNode curr = mid.next;
        while (curr != null) {
            ListNode next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }
        mid.next = null;

        ListNode left = head;
        ListNode right = prev;
        while (right != null) {
            ListNode nextLeft = left.next;
            ListNode nextRight = right.next;
            left.next = right;
            right.next = nextLeft;
            left = nextLeft;
            right = nextRight;
        }
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}