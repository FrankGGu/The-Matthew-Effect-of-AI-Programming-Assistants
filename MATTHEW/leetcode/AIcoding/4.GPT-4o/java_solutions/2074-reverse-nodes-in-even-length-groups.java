class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode reverseEvenLengthGroups(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode current = head;
        int groupSize = 1;
        int groupIndex = 0;

        while (current != null) {
            ListNode groupHead = current;
            ListNode prev = null;
            int count = 0;

            while (current != null && count < groupSize) {
                prev = current;
                current = current.next;
                count++;
            }

            if (count % 2 == 0) {
                ListNode nextGroupHead = current;
                ListNode reversedGroupHead = reverse(groupHead, count);
                groupHead.next = nextGroupHead;
                if (groupIndex == 0) {
                    dummy.next = reversedGroupHead;
                } else {
                    ListNode temp = getGroupHead(dummy, groupIndex);
                    temp.next = reversedGroupHead;
                }
            } else {
                if (groupIndex > 0) {
                    ListNode temp = getGroupHead(dummy, groupIndex);
                    temp.next = groupHead;
                }
            }

            groupIndex++;
            groupSize++;
        }

        return dummy.next;
    }

    private ListNode reverse(ListNode head, int count) {
        ListNode prev = null;
        ListNode current = head;
        while (count > 0) {
            ListNode next = current.next;
            current.next = prev;
            prev = current;
            current = next;
            count--;
        }
        return prev;
    }

    private ListNode getGroupHead(ListNode dummy, int index) {
        ListNode current = dummy;
        for (int i = 0; i <= index; i++) {
            current = current.next;
        }
        return current;
    }
}