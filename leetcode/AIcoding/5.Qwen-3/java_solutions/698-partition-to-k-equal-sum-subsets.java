public class Solution {

import java.util.Arrays;

public class Solution {
    public boolean canPartitionKSubsets(int[] nums, int k) {
        int sum = Arrays.stream(nums).sum();
        if (sum % k != 0) return false;
        int target = sum / k;
        Arrays.sort(nums);
        if (nums[nums.length - 1] > target) return false;
        boolean[] used = new boolean[nums.length];
        return backtrack(nums, target, 0, 0, used, k);
    }

    private boolean backtrack(int[] nums, int target, int start, int currentSum, boolean[] used, int k) {
        if (k == 0) return true;
        if (currentSum == target) {
            return backtrack(nums, target, 0, 0, used, k - 1);
        }
        for (int i = start; i < nums.length; i++) {
            if (!used[i] && currentSum + nums[i] <= target) {
                used[i] = true;
                if (backtrack(nums, target, i + 1, currentSum + nums[i], used, k)) {
                    return true;
                }
                used[i] = false;
            }
        }
        return false;
    }
}
}