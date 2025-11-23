public class Solution {

import java.util.*;

public class Solution {
    public ListNode[] splitListToParts(ListNode root, int k) {
        ListNode[] result = new ListNode[k];
        int length = 0;
        ListNode current = root;
        while (current != null) {
            length++;
            current = current.next;
        }

        int partSize = length / k;
        int remainder = length % k;

        current = root;
        for (int i = 0; i < k; i++) {
            result[i] = current;
            int size = partSize + (i < remainder ? 1 : 0);
            for (int j = 0; j < size - 1; j++) {
                current = current.next;
            }
            if (current != null) {
                ListNode next = current.next;
                current.next = null;
                current = next;
            }
        }

        return result;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}
}