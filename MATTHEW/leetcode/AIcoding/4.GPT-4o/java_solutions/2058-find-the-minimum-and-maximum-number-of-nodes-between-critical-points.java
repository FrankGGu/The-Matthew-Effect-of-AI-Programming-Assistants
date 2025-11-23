class Solution {
    public int[] nodesBetweenCriticalPoints(ListNode head) {
        List<Integer> criticalPoints = new ArrayList<>();
        ListNode prev = null, curr = head, next = head.next;
        int pos = 0;

        while (next != null) {
            if ((prev == null || curr.val > prev.val) && curr.val > next.val) {
                criticalPoints.add(pos);
            } else if ((prev == null || curr.val < prev.val) && curr.val < next.val) {
                criticalPoints.add(pos);
            }
            prev = curr;
            curr = next;
            next = next.next;
            pos++;
        }

        if (criticalPoints.size() < 2) {
            return new int[] {-1, -1};
        }

        int minDiff = Integer.MAX_VALUE;
        for (int i = 1; i < criticalPoints.size(); i++) {
            minDiff = Math.min(minDiff, criticalPoints.get(i) - criticalPoints.get(i - 1));
        }

        return new int[] {minDiff, criticalPoints.get(criticalPoints.size() - 1) - criticalPoints.get(0)};
    }
}