public class Solution {
    public ListNode reverseEvenLengthGroups(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        int length = 0;
        while (head != null) {
            length++;
            head = head.next;
        }
        int group = 1;
        head = dummy.next;
        while (head != null) {
            int count = 0;
            ListNode start = head;
            ListNode end = head;
            while (count < group && end != null) {
                end = end.next;
                count++;
            }
            if (count % 2 == 0) {
                ListNode prevGroup = prev;
                ListNode curr = start;
                ListNode next = null;
                while (curr != end) {
                    next = curr.next;
                    curr.next = prevGroup;
                    prevGroup = curr;
                    curr = next;
                }
                prev.next = prevGroup;
                prev = start;
                prev.next = end;
            } else {
                prev = end;
            }
            head = end;
            group++;
        }
        return dummy.next;
    }
}