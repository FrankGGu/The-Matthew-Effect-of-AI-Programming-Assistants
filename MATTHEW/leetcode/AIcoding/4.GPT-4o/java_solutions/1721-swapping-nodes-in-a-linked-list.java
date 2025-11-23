class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode swapNodes(ListNode head, int k) {
        ListNode first = head, second = head, current = head;
        int count = 1;

        while (current != null) {
            if (count < k) {
                first = first.next;
            }
            if (count > k) {
                second = second.next;
            }
            current = current.next;
            count++;
        }

        int temp = first.val;
        first.val = second.val;
        second.val = temp;

        return head;
    }
}