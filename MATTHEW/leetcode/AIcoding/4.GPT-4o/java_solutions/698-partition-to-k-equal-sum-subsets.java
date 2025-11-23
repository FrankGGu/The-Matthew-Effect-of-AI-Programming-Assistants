import java.util.Arrays;

public class Solution {
    public boolean canPartitionKSubsets(int[] nums, int k) {
        int sum = Arrays.stream(nums).sum();
        if (k <= 0 || sum % k != 0) return false;
        int target = sum / k;
        Arrays.sort(nums);
        if (nums[nums.length - 1] > target) return false;
        boolean[] visited = new boolean[nums.length];
        return backtrack(nums, visited, k, 0, 0, target);
    }

    private boolean backtrack(int[] nums, boolean[] visited, int k, int startIndex, int currentSum, int target) {
        if (k == 1) return true;
        if (currentSum == target) return backtrack(nums, visited, k - 1, 0, 0, target);
        for (int i = startIndex; i < nums.length; i++) {
            if (!visited[i] && currentSum + nums[i] <= target) {
                visited[i] = true;
                if (backtrack(nums, visited, k, i + 1, currentSum + nums[i], target)) return true;
                visited[i] = false;
            }
        }
        return false;
    }
}