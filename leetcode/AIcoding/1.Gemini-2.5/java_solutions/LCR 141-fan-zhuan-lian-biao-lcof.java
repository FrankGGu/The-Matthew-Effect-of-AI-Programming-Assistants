import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestEqualSubarray(int[] nums, int k) {
        int n = nums.length;
        Map<Integer, Integer> counts = new HashMap<>();
        int left = 0;
        int maxFreq = 0; 

        for (int right = 0; right < n; right++) {
            int num_r = nums[right];
            counts.put(num_r, counts.getOrDefault(num_r, 0) + 1);
            maxFreq = Math.max(maxFreq, counts.get(num_r));

            // The condition to check if the current window [left, right] is valid
            // is that (total elements in window - count of most frequent element) <= k.
            // If this condition is violated, we need to shrink the window from the left.
            // The `maxFreq` variable stores the maximum frequency of any element encountered
            // in any window considered so far. It is not recomputed when `left` moves.
            // This is valid because we are looking for the maximum possible `maxFreq` (length
            // of the equal subarray). If the current window, even with a potentially
            // 'overestimated' `maxFreq`, requires more than `k` deletions, then shrinking
            // is necessary.
            while ((right - left + 1) - maxFreq > k) {
                int num_l = nums[left];
                counts.put(num_l, counts.get(num_l) - 1);
                left++;
            }
        }
        return maxFreq;
    }
}