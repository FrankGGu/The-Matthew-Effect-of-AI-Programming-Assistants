class Solution {
    public ListNode reverseEvenLengthGroups(ListNode head) {
        ListNode dummyHead = new ListNode(0, head);
        ListNode prevGroupTail = dummyHead;
        int k = 1;

        while (prevGroupTail.next != null) {
            ListNode groupHead = prevGroupTail.next;
            ListNode curr = groupHead;
            int count = 0;
            ListNode groupTail = null;

            // Find the end of the current group and count nodes
            for (int i = 0; i < k; i++) {
                if (curr == null) {
                    break;
                }
                groupTail = curr;
                curr = curr.next;
                count++;
            }

            // If the group length is even, reverse it
            if (count % 2 == 0) {
                ListNode nextGroupHead = curr; // This is the node after the current group

                // Reverse the current group (from groupHead to groupTail)
                ListNode prev = nextGroupHead;
                ListNode current = groupHead;
                ListNode tempNext;
                while (current != nextGroupHead) {
                    tempNext = current.next;
                    current.next = prev;
                    prev = current;
                    current = tempNext;
                }

                // Connect the reversed group back to the list
                prevGroupTail.next = groupTail; // The original groupTail is now the new head
                prevGroupTail = groupHead;       // The original groupHead is now the new tail
            } else {
                // If odd, just move prevGroupTail to the end of this group
                prevGroupTail = groupTail;
            }

            k++;
        }

        return dummyHead.next;
    }
}