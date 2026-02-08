class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode insertionSortList(ListNode head) {
        if (head == null) return null;

        ListNode sorted = new ListNode(0);

        ListNode current = head;
        while (current != null) {
            ListNode prev = sorted;
            while (prev.next != null && prev.next.val < current.val) {
                prev = prev.next;
            }
            ListNode next = current.next;
            current.next = prev.next;
            prev.next = current;
            current = next;
        }

        return sorted.next;
    }
}