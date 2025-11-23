class Solution {
    public ListNode reverseEvenLengthGroups(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        int groupLength = 1;

        while (prev.next != null) {
            ListNode current = prev.next;
            ListNode tail = current;
            int count = 0;

            while (tail != null && count < groupLength) {
                tail = tail.next;
                count++;
            }

            if (count % 2 == 0) {
                ListNode nextGroup = tail;
                ListNode reversedHead = null;
                ListNode reversedTail = current;

                ListNode temp = current;
                for (int i = 0; i < count; i++) {
                    ListNode next = temp.next;
                    temp.next = reversedHead;
                    reversedHead = temp;
                    temp = next;
                }

                prev.next = reversedHead;
                reversedTail.next = nextGroup;
                prev = reversedTail;
            } else {
                for (int i = 0; i < count; i++) {
                    prev = current;
                    current = current.next;
                }
            }

            groupLength++;
        }

        return dummy.next;
    }
}