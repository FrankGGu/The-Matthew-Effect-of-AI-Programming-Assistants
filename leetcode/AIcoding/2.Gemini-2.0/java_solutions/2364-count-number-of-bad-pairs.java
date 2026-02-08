import java.util.HashMap;
import java.util.Map;

class Solution {
    public long countBadPairs(int[] nums) {
        int n = nums.length;
        long badPairs = 0;
        Map<Integer, Integer> count = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int diff = nums[i] - i;
            badPairs += i - count.getOrDefault(diff, 0);
            count.put(diff, count.getOrDefault(diff, 0) + 1);
        }

        return badPairs;
    }
}