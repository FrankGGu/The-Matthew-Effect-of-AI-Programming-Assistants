class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode mergeInBetween(ListNode list1, int a, int b, ListNode list2) {
        ListNode dummy = new ListNode(0);
        dummy.next = list1;
        ListNode prev = dummy;

        for (int i = 0; i < a; i++) {
            prev = prev.next;
        }

        ListNode tail = prev;
        for (int i = a; i <= b; i++) {
            tail = tail.next;
        }

        prev.next = list2;

        while (prev.next != null) {
            prev = prev.next;
        }

        prev.next = tail;
        return dummy.next;
    }
}