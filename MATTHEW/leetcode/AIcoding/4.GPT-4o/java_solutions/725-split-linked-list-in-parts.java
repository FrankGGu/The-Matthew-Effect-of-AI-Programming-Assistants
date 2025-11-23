class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class Solution {
    public ListNode[] splitListToParts(ListNode root, int k) {
        ListNode[] parts = new ListNode[k];
        int length = 0;
        ListNode curr = root;

        while (curr != null) {
            length++;
            curr = curr.next;
        }

        int size = length / k;
        int remainder = length % k;
        curr = root;

        for (int i = 0; i < k; i++) {
            parts[i] = curr;
            int currentPartSize = size + (i < remainder ? 1 : 0);
            for (int j = 0; j < currentPartSize - 1; j++) {
                if (curr != null) {
                    curr = curr.next;
                }
            }
            if (curr != null) {
                ListNode nextPart = curr.next;
                curr.next = null;
                curr = nextPart;
            }
        }

        return parts;
    }
}