class Solution {
    public boolean canPartitionKSubsets(int[] nums, int k) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum % k != 0) {
            return false;
        }
        int target = sum / k;
        int n = nums.length;
        boolean[] visited = new boolean[n];
        return canPartition(nums, k, target, 0, 0, visited);
    }

    private boolean canPartition(int[] nums, int k, int target, int currentSum, int start, boolean[] visited) {
        if (k == 0) {
            return true;
        }
        if (currentSum == target) {
            return canPartition(nums, k - 1, target, 0, 0, visited);
        }
        for (int i = start; i < nums.length; i++) {
            if (!visited[i] && currentSum + nums[i] <= target) {
                visited[i] = true;
                if (canPartition(nums, k, target, currentSum + nums[i], i + 1, visited)) {
                    return true;
                }
                visited[i] = false;
            }
        }
        return false;
    }
}