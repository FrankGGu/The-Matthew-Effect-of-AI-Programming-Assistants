class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode removeZeroSumSublists(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        Map<Integer, ListNode> map = new HashMap<>();
        int sum = 0;
        ListNode curr = dummy;

        while (curr != null) {
            sum += curr.val;
            map.put(sum, curr);
            curr = curr.next;
        }

        sum = 0;
        curr = dummy;

        while (curr != null) {
            sum += curr.val;
            curr.next = map.get(sum).next;
            curr = curr.next;
        }

        return dummy.next;
    }
}