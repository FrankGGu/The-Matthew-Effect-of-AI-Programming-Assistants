import java.util.HashSet;

public class Solution {
    public int maximumSumDistinctSubarrays(int[] nums, int k) {
        int n = nums.length;
        if (n < k) return 0;

        HashSet<Integer> set = new HashSet<>();
        int maxSum = 0;
        int currentSum = 0;

        for (int i = 0; i < k; i++) {
            if (!set.add(nums[i])) return 0;
            currentSum += nums[i];
        }
        maxSum = currentSum;

        for (int i = k; i < n; i++) {
            if (set.remove(nums[i - k])) {
                currentSum -= nums[i - k];
            }
            if (!set.add(nums[i])) {
                set.add(nums[i - k]);
                continue;
            }
            currentSum += nums[i];
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}