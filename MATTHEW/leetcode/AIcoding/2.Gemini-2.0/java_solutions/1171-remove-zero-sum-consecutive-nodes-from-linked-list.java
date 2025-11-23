class Solution {
    public ListNode removeZeroSumSublists(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;

        java.util.Map<Integer, ListNode> map = new java.util.HashMap<>();
        map.put(0, dummy);

        int prefixSum = 0;
        ListNode curr = head;
        while (curr != null) {
            prefixSum += curr.val;

            if (map.containsKey(prefixSum)) {
                ListNode node = map.get(prefixSum);
                ListNode toRemove = node.next;
                int sum = prefixSum;
                while (toRemove != curr) {
                    sum += toRemove.val;
                    map.remove(sum);
                    toRemove = toRemove.next;
                }
                node.next = curr.next;
            } else {
                map.put(prefixSum, curr);
            }

            curr = curr.next;
        }

        return dummy.next;
    }
}