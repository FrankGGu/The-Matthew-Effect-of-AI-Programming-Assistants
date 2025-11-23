import java.util.HashSet;

class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode deleteNodes(ListNode head, int[] to_delete) {
        HashSet<Integer> toDeleteSet = new HashSet<>();
        for (int num : to_delete) {
            toDeleteSet.add(num);
        }

        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;

        while (head != null) {
            if (toDeleteSet.contains(head.val)) {
                prev.next = head.next;
            } else {
                prev = head;
            }
            head = head.next;
        }

        return dummy.next;
    }
}