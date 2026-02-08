import java.util.HashSet;

class Solution {
    public int longestSquareStreak(int[] nums) {
        HashSet<Integer> set = new HashSet<>();
        for (int num : nums) {
            set.add(num);
        }
        int maxStreak = 0;

        for (int num : nums) {
            int streak = 0;
            int current = num;

            while (set.contains(current)) {
                streak++;
                current *= current;
                if (current > Integer.MAX_VALUE) break;
            }
            maxStreak = Math.max(maxStreak, streak);
        }
        return maxStreak < 2 ? -1 : maxStreak;
    }
}