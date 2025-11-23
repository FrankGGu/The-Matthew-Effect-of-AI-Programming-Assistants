class Solution {
    public void reorderList(ListNode head) {
        if (head == null || head.next == null) {
            return;
        }

        // Step 1: Find the middle of the linked list
        ListNode slow = head;
        ListNode fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        // Step 2: Split the list into two halves
        // head1 is the first half, head2 is the second half
        ListNode head1 = head;
        ListNode head2 = slow.next;
        slow.next = null; // Break the link to separate the two halves

        // Step 3: Reverse the second half
        ListNode prev = null;
        ListNode curr = head2;
        while (curr != null) {
            ListNode nextTemp = curr.next;
            curr.next = prev;
            prev = curr;
            curr = nextTemp;
        }
        head2 = prev; // head2 now points to the head of the reversed second half

        // Step 4: Merge the two halves alternately
        ListNode p1 = head1;
        ListNode p2 = head2;
        while (p1 != null && p2 != null) {
            ListNode next1 = p1.next;
            ListNode next2 = p2.next;

            p1.next = p2;
            p2.next = next1;

            p1 = next1;
            p2 = next2;
        }
    }
}