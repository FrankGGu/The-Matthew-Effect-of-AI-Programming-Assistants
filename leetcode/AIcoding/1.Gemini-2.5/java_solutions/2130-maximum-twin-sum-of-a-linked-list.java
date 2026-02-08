class Solution {
    public int maxTwinSum(ListNode head) {
        ListNode slow = head;
        ListNode fast = head;

        // Find the middle of the linked list
        // 'slow' will point to the head of the second half
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        // Reverse the second half of the linked list
        ListNode prev = null;
        ListNode curr = slow;
        while (curr != null) {
            ListNode nextTemp = curr.next;
            curr.next = prev;
            prev = curr;
            curr = nextTemp;
        }

        // 'prev' is now the head of the reversed second half
        // 'head' is the head of the first half

        int maxTwinSum = 0;
        ListNode p1 = head; // Pointer for the first half
        ListNode p2 = prev; // Pointer for the reversed second half

        // Calculate twin sums and find the maximum
        while (p1 != null && p2 != null) {
            maxTwinSum = Math.max(maxTwinSum, p1.val + p2.val);
            p1 = p1.next;
            p2 = p2.next;
        }

        return maxTwinSum;
    }
}