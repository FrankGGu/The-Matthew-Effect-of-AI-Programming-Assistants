class Solution {
    public ListNode[] splitListToParts(ListNode head, int k) {
        int length = 0;
        ListNode current = head;
        while (current != null) {
            length++;
            current = current.next;
        }

        int baseSize = length / k;
        int extra = length % k;

        ListNode[] result = new ListNode[k];
        current = head;

        for (int i = 0; i < k; i++) {
            result[i] = current;
            int currentSize = baseSize + (i < extra ? 1 : 0);

            if (current == null) {
                continue;
            }

            for (int j = 1; j < currentSize; j++) {
                current = current.next;
            }

            ListNode nextHead = null;
            if (current != null) {
                nextHead = current.next;
                current.next = null;
            }
            current = nextHead;
        }

        return result;
    }
}