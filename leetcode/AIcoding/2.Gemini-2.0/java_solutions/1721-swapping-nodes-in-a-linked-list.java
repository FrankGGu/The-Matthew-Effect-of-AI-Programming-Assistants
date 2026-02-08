class Solution {
    public ListNode swapNodes(ListNode head, int k) {
        ListNode first = null;
        ListNode second = null;
        ListNode curr = head;
        int count = 1;

        while (curr != null) {
            if (count == k) {
                first = curr;
            }
            curr = curr.next;
            count++;
        }

        curr = head;
        for (int i = 1; i <= count - k - 1; i++) {
            curr = curr.next;
        }
        second = curr;

        int temp = first.val;
        first.val = second.val;
        second.val = temp;

        return head;
    }
}