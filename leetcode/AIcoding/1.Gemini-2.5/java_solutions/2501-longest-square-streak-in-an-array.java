import java.util.HashSet;
import java.util.Set;

class Solution {
    public int longestSquareStreak(int[] nums) {
        Set<Integer> numSet = new HashSet<>();
        for (int num : nums) {
            numSet.add(num);
        }

        int maxStreak = -1;

        for (int num : nums) {
            int currentStreak = 1;
            long currentVal = num;

            while (true) {
                long nextVal = currentVal * currentVal;

                // Check for overflow and if nextVal exceeds the maximum possible value in nums (10^5)
                // If nextVal is too large, it cannot be in the numSet.
                // Using 200000 as a safe upper bound slightly above 10^5 to avoid issues with intermediate values
                // or if problem constraints were slightly different.
                // The actual max value in nums is 10^5.
                if (nextVal > 100000) { 
                    break;
                }

                if (numSet.contains((int) nextVal)) {
                    currentStreak++;
                    currentVal = nextVal;
                } else {
                    break;
                }
            }

            if (currentStreak >= 2) {
                maxStreak = Math.max(maxStreak, currentStreak);
            }
        }

        return maxStreak;
    }
}