public class Solution {
    public int[] nodesBetweenCriticalPoints(ListNode head) {
        if (head == null || head.next == null || head.next.next == null) {
            return new int[]{-1, -1};
        }

        ListNode prev = head;
        ListNode curr = head.next;
        ListNode next = head.next.next;

        int firstIndex = -1;
        int lastIndex = -1;
        int minDistance = Integer.MAX_VALUE;
        int index = 1;

        while (next != null) {
            if ((curr.val > prev.val && curr.val > next.val) || (curr.val < prev.val && curr.val < next.val)) {
                if (firstIndex == -1) {
                    firstIndex = index;
                } else {
                    minDistance = Math.min(minDistance, index - lastIndex);
                }
                lastIndex = index;
            }
            prev = curr;
            curr = next;
            next = next.next;
            index++;
        }

        if (firstIndex == -1 || lastIndex == -1 || firstIndex == lastIndex) {
            return new int[]{-1, -1};
        }

        return new int[]{minDistance, lastIndex - firstIndex};
    }
}