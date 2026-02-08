public class Solution {
    public ListNode detectCycle(ListNode head) {
        if (head == null || head.next == null) {
            return null;
        }

        ListNode slow = head;
        ListNode fast = head;

        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;

            if (slow == fast) {
                // Cycle detected
                slow = head; // Reset slow to head
                while (slow != fast) {
                    slow = slow.next;
                    fast = fast.next;
                }
                return slow; // This is the start of the cycle
            }
        }

        return null; // No cycle
    }
}