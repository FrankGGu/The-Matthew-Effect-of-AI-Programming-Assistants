public class Solution {
    public ListNode reverseKGroup(ListNode head, int k) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        ListNode curr = head;

        while (true) {
            int count = 0;
            ListNode last = prev;
            while (count < k && last.next != null) {
                last = last.next;
                count++;
            }
            if (count < k) break;

            ListNode next = last.next;
            ListNode start = prev.next;
            ListNode end = last;

            ListNode p = start;
            ListNode q = p.next;
            p.next = null;

            while (q != null) {
                ListNode temp = q.next;
                q.next = p;
                p = q;
                q = temp;
            }

            prev.next = p;
            start.next = next;
            prev = start;
            curr = next;
        }

        return dummy.next;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}