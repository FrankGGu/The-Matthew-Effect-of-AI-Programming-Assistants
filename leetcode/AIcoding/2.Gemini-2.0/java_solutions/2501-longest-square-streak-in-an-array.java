import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int longestSquareStreak(int[] nums) {
        Set<Integer> numSet = new HashSet<>();
        for (int num : nums) {
            numSet.add(num);
        }

        int maxStreak = 0;
        for (int num : nums) {
            int current = num;
            int streak = 1;
            while (true) {
                long next = (long) current * current;
                if (next > Integer.MAX_VALUE || !numSet.contains((int) next)) {
                    break;
                }
                current = (int) next;
                streak++;
            }
            maxStreak = Math.max(maxStreak, streak);
        }

        return maxStreak > 1 ? maxStreak : -1;
    }
}