class Solution {
    public long numberOfWeeks(int[] milestones) {
        long sum = 0;
        long max = 0;
        for (int m : milestones) {
            sum += m;
            if (m > max) {
                max = m;
            }
        }

        if (max > sum - max + 1) {
            return 2 * (sum - max) + 1;
        } else {
            return sum;
        }
    }
}