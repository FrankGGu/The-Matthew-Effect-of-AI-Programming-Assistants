public class Solution {
    public ListNode partition(ListNode head, int x) {
        ListNode dummyLess = new ListNode(0);
        ListNode dummyGreater = new ListNode(0);
        ListNode less = dummyLess;
        ListNode greater = dummyGreater;

        while (head != null) {
            if (head.val < x) {
                less.next = head;
                less = head;
            } else {
                greater.next = head;
                greater = head;
            }
            head = head.next;
        }

        less.next = dummyGreater.next;
        greater.next = null;

        return dummyLess.next;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}