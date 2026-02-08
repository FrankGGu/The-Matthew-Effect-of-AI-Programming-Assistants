class Solution {
    public int numberOfWeeks(int[] milestones) {
        long sum = 0;
        int max = 0;
        for (int milestone : milestones) {
            sum += milestone;
            max = Math.max(max, milestone);
        }
        long remaining = sum - max;
        if (max > remaining) {
            return (int) (2 * remaining + 1);
        } else {
            return (int) sum;
        }
    }
}