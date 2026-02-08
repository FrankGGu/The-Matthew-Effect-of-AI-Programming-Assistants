public class Solution {
    public ListNode detectCycle(ListNode head) {
        if (head == null || head.next == null) {
            return null;
        }

        ListNode slow = head;
        ListNode fast = head;
        boolean cycleDetected = false;

        // Step 1: Detect if a cycle exists using Floyd's Cycle-Finding Algorithm
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            if (slow == fast) {
                cycleDetected = true;
                break;
            }
        }

        // Step 2: If no cycle was detected, return null
        if (!cycleDetected) {
            return null;
        }

        // Step 3: Find the starting node of the cycle
        // Move one pointer to the head of the list
        // Keep the other pointer at the meeting point
        ListNode ptr1 = head;
        ListNode ptr2 = slow; // 'slow' is currently at the meeting point

        // Move both pointers one step at a time
        // They will meet at the start of the cycle
        while (ptr1 != ptr2) {
            ptr1 = ptr1.next;
            ptr2 = ptr2.next;
        }

        return ptr1; // ptr1 (or ptr2) is the start of the cycle
    }
}