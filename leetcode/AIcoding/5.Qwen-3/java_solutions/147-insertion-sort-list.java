public class Solution {
    public ListNode insertionSortList(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode dummy = new ListNode(0);
        ListNode current = head;

        while (current != null) {
            ListNode temp = dummy;
            while (temp.next != null && temp.next.val < current.val) {
                temp = temp.next;
            }
            ListNode nextNode = current.next;
            current.next = temp.next;
            temp.next = current;
            current = nextNode;
        }

        return dummy.next;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}