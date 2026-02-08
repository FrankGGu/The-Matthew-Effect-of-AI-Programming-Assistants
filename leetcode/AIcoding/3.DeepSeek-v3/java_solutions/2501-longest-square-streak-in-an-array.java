import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int longestSquareStreak(int[] nums) {
        Set<Long> set = new HashSet<>();
        for (int num : nums) {
            set.add((long) num);
        }
        Arrays.sort(nums);
        int maxStreak = -1;
        for (int num : nums) {
            long current = num;
            int streak = 1;
            while (set.contains(current * current)) {
                current *= current;
                streak++;
            }
            if (streak >= 2) {
                maxStreak = Math.max(maxStreak, streak);
            }
        }
        return maxStreak;
    }
}