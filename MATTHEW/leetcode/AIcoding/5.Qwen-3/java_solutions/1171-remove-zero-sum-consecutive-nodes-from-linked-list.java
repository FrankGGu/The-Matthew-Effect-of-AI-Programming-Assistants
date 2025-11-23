public class Solution {
    public ListNode removeZeroSumSubarrays(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode current = dummy;
        int prefixSum = 0;
        HashMap<Integer, ListNode> sumMap = new HashMap<>();
        sumMap.put(0, dummy);

        while (current != null) {
            prefixSum += current.val;
            if (sumMap.containsKey(prefixSum)) {
                ListNode prev = sumMap.get(prefixSum);
                current = prev.next;
                int tempSum = prefixSum;
                while (current != null) {
                    tempSum += current.val;
                    sumMap.remove(tempSum);
                    current = current.next;
                }
                prev.next = current;
            } else {
                sumMap.put(prefixSum, current);
            }
            current = current.next;
        }

        return dummy.next;
    }
}