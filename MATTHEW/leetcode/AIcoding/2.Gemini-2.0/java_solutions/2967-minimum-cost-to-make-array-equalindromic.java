import java.util.Arrays;

class Solution {
    public long minimumCost(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int median = nums[n / 2];
        return calculateCost(nums, median);
    }

    private long calculateCost(int[] nums, int target) {
        long cost = 0;
        for (int num : nums) {
            cost += Math.abs((long) num - target);
        }
        return cost;
    }
}