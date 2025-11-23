public class Solution {
    public long numberOfWeeks(int[] milestones) {
        long sum = 0;
        for (int m : milestones) {
            sum += m;
        }
        long max = 0;
        for (int m : milestones) {
            if (m > max) {
                max = m;
            }
        }
        if (sum - max >= max - 1) {
            return sum;
        } else {
            return 2 * (sum - max) + 1;
        }
    }
}