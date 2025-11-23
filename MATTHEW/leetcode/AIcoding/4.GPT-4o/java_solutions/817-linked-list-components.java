import java.util.HashSet;

class Solution {
    public int numComponents(ListNode head, int[] G) {
        HashSet<Integer> set = new HashSet<>();
        for (int g : G) {
            set.add(g);
        }

        int count = 0;
        boolean inComponent = false;

        while (head != null) {
            if (set.contains(head.val)) {
                if (!inComponent) {
                    count++;
                    inComponent = true;
                }
            } else {
                inComponent = false;
            }
            head = head.next;
        }

        return count;
    }
}