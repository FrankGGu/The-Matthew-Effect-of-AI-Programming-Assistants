class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

class Solution {
    public ListNode mergeNodes(ListNode head) {
        ListNode dummy = new ListNode(0);
        ListNode curr = dummy;
        int sum = 0;

        head = head.next; // Skip the first zero
        while (head != null) {
            if (head.val == 0) {
                if (sum > 0) {
                    curr.next = new ListNode(sum);
                    curr = curr.next;
                    sum = 0;
                }
            } else {
                sum += head.val;
            }
            head = head.next;
        }

        return dummy.next;
    }
}