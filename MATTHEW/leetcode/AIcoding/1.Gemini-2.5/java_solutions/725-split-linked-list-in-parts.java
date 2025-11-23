class Solution {
    public ListNode[] splitListToParts(ListNode head, int k) {
        int len = 0;
        ListNode current = head;
        while (current != null) {
            len++;
            current = current.next;
        }

        int baseSize = len / k;
        int remainder = len % k;

        ListNode[] result = new ListNode[k];
        current = head;

        for (int i = 0; i < k; i++) {
            result[i] = current;

            int currentPartSize = baseSize + (i < remainder ? 1 : 0);

            ListNode prev = null;
            for (int j = 0; j < currentPartSize; j++) {
                prev = current;
                current = current.next;
            }

            if (prev != null) {
                prev.next = null;
            }
        }

        return result;
    }
}