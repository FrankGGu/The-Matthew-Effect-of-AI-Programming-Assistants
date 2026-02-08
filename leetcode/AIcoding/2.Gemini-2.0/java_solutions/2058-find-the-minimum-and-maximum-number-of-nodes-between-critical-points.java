class Solution {
    public int[] nodesBetweenCriticalPoints(ListNode head) {
        if (head == null || head.next == null || head.next.next == null) {
            return new int[]{-1, -1};
        }

        ListNode prev = head;
        ListNode curr = head.next;
        int index = 1;
        int first = -1;
        int last = -1;
        int minDistance = Integer.MAX_VALUE;
        int lastCriticalPoint = -1;

        while (curr.next != null) {
            ListNode next = curr.next;
            if ((curr.val > prev.val && curr.val > next.val) || (curr.val < prev.val && curr.val < next.val)) {
                if (first == -1) {
                    first = index;
                    lastCriticalPoint = index;
                } else {
                    minDistance = Math.min(minDistance, index - lastCriticalPoint);
                    lastCriticalPoint = index;
                }
                last = index;
            }
            prev = curr;
            curr = next;
            index++;
        }

        if (first == last) {
            return new int[]{-1, -1};
        }

        return new int[]{minDistance, last - first};
    }
}