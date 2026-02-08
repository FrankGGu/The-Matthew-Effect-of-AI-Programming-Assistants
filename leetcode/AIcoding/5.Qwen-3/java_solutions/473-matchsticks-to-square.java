public class Solution {

import java.util.Arrays;

public class Solution {
    public boolean canPartitionKSubsets(int[] nums, int k) {
        int total = Arrays.stream(nums).sum();
        if (total % k != 0) return false;
        int target = total / k;
        Arrays.sort(nums);
        if (nums[nums.length - 1] > target) return false;
        boolean[] used = new boolean[nums.length];
        return backtrack(nums, target, 0, 0, used, 0, k);
    }

    private boolean backtrack(int[] nums, int target, int start, int currentSum, boolean[] used, int count, int k) {
        if (count == k) return true;
        if (currentSum == target) return backtrack(nums, target, 0, 0, used, count + 1, k);
        for (int i = start; i < nums.length; i++) {
            if (!used[i] && currentSum + nums[i] <= target) {
                used[i] = true;
                if (backtrack(nums, target, i + 1, currentSum + nums[i], used, count, k)) return true;
                used[i] = false;
            }
        }
        return false;
    }
}
}