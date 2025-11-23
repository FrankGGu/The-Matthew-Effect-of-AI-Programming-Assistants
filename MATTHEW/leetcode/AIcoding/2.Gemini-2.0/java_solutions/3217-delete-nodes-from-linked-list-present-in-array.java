class Solution {
    public ListNode removeNodes(ListNode head, int[] values) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode curr = head;
        ListNode prev = dummy;

        HashSet<Integer> set = new HashSet<>();
        for (int val : values) {
            set.add(val);
        }

        while (curr != null) {
            if (set.contains(curr.val)) {
                prev.next = curr.next;
                curr = curr.next;
            } else {
                prev = curr;
                curr = curr.next;
            }
        }

        return dummy.next;
    }
}