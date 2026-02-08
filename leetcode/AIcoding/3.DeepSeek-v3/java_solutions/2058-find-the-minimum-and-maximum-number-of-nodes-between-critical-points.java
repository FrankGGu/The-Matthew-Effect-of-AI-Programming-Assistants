class Solution {
    public int[] nodesBetweenCriticalPoints(ListNode head) {
        if (head == null || head.next == null || head.next.next == null) {
            return new int[]{-1, -1};
        }

        ListNode prev = head;
        ListNode curr = head.next;
        ListNode next = curr.next;
        int first = -1;
        int last = -1;
        int minDist = Integer.MAX_VALUE;
        int index = 1;
        List<Integer> criticalIndices = new ArrayList<>();

        while (next != null) {
            if ((curr.val > prev.val && curr.val > next.val) || (curr.val < prev.val && curr.val < next.val)) {
                criticalIndices.add(index);
                if (first == -1) {
                    first = index;
                }
                if (last != -1) {
                    minDist = Math.min(minDist, index - last);
                }
                last = index;
            }
            prev = curr;
            curr = next;
            next = next.next;
            index++;
        }

        if (criticalIndices.size() < 2) {
            return new int[]{-1, -1};
        }

        int maxDist = criticalIndices.get(criticalIndices.size() - 1) - criticalIndices.get(0);
        return new int[]{minDist, maxDist};
    }
}