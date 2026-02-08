import java.util.HashMap;
import java.util.Map;

class Solution {
    public int destroyTargets(int[] nums, int space) {
        Map<Integer, Integer> remainderCounts = new HashMap<>();
        for (int num : nums) {
            int remainder = num % space;
            remainderCounts.put(remainder, remainderCounts.getOrDefault(remainder, 0) + 1);
        }

        int maxCount = 0;
        int minFirstTarget = Integer.MAX_VALUE;

        for (int num : nums) {
            int remainder = num % space;
            int currentCount = remainderCounts.get(remainder);

            if (currentCount > maxCount) {
                maxCount = currentCount;
                minFirstTarget = num;
            } else if (currentCount == maxCount) {
                minFirstTarget = Math.min(minFirstTarget, num);
            }
        }

        return minFirstTarget;
    }
}