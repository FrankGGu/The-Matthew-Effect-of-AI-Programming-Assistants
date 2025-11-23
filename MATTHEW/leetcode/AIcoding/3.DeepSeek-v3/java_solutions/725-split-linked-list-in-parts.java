class Solution {
    public ListNode[] splitListToParts(ListNode head, int k) {
        ListNode[] parts = new ListNode[k];
        int length = 0;
        ListNode node = head;
        while (node != null) {
            length++;
            node = node.next;
        }
        int n = length / k, r = length % k;
        node = head;
        ListNode prev = null;
        for (int i = 0; node != null && i < k; i++, r--) {
            parts[i] = node;
            int partSize = n + (r > 0 ? 1 : 0);
            for (int j = 0; j < partSize; j++) {
                prev = node;
                node = node.next;
            }
            if (prev != null) {
                prev.next = null;
            }
        }
        return parts;
    }
}