class Solution {
    public ListNode mergeNodes(ListNode head) {
        ListNode dummy = new ListNode(0);
        ListNode currentNew = dummy;
        ListNode currentOld = head.next;

        while (currentOld != null) {
            int currentSum = 0;
            while (currentOld.val != 0) {
                currentSum += currentOld.val;
                currentOld = currentOld.next;
            }

            currentNew.next = new ListNode(currentSum);
            currentNew = currentNew.next;

            currentOld = currentOld.next;
        }

        return dummy.next;
    }
}