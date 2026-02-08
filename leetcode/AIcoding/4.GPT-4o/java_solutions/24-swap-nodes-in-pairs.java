class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode swapPairs(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode newHead = head.next;
        ListNode prev = null;
        ListNode current = head;

        while (current != null && current.next != null) {
            ListNode nextPair = current.next.next;
            ListNode second = current.next;

            second.next = current;
            current.next = nextPair;
            if (prev != null) {
                prev.next = second;
            }
            prev = current;
            current = nextPair;
        }

        return newHead;
    }
}