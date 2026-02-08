class Solution {
    public void reorderList(ListNode head) {
        if (head == null || head.next == null) {
            return;
        }

        ListNode slow = head;
        ListNode fast = head;
        while (fast.next != null && fast.next.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        ListNode head1 = head;
        ListNode head2 = slow.next;
        slow.next = null;

        head2 = reverseList(head2);

        mergeLists(head1, head2);
    }

    private ListNode reverseList(ListNode head) {
        ListNode prev = null;
        ListNode curr = head;
        while (curr != null) {
            ListNode nextTemp = curr.next;
            curr.next = prev;
            prev = curr;
            curr = nextTemp;
        }
        return prev;
    }

    private void mergeLists(ListNode l1, ListNode l2) {
        while (l1 != null && l2 != null) {
            ListNode l1_next = l1.next;
            ListNode l2_next = l2.next;

            l1.next = l2;
            if (l1_next == null) {
                break;
            }
            l2.next = l1_next;

            l1 = l1_next;
            l2 = l2_next;
        }
    }
}