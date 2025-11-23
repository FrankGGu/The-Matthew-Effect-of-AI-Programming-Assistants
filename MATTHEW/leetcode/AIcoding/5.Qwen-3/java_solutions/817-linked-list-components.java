public class Solution {
    public int numComponents(ListNode head, int[] G) {
        boolean[] inSet = new boolean[10000];
        for (int g : G) {
            inSet[g] = true;
        }
        int count = 0;
        while (head != null) {
            if (inSet[head.val] && (head.next == null || !inSet[head.next.val])) {
                count++;
            }
            head = head.next;
        }
        return count;
    }

    public class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}