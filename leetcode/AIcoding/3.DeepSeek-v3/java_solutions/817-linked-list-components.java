import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numComponents(ListNode head, int[] nums) {
        Set<Integer> numSet = new HashSet<>();
        for (int num : nums) {
            numSet.add(num);
        }

        int components = 0;
        boolean inComponent = false;

        ListNode current = head;
        while (current != null) {
            if (numSet.contains(current.val)) {
                if (!inComponent) {
                    components++;
                    inComponent = true;
                }
            } else {
                inComponent = false;
            }
            current = current.next;
        }

        return components;
    }
}

class ListNode {
    int val;
    ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}