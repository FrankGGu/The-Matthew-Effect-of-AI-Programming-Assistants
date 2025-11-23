class Solution {
    public long numberOfWeeks(int[] milestones) {
        long sum = 0;
        long max = 0;
        for (int milestone : milestones) {
            sum += milestone;
            max = Math.max(max, milestone);
        }
        long remaining = sum - max;
        if (max <= remaining + 1) {
            return sum;
        } else {
            return 2 * remaining + 1;
        }
    }
}