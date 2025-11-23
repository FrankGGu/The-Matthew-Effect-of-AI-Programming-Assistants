import java.util.Arrays;

class Solution {
    public int findMinimumCost(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int cost = 0;
        for (int i = 0; i < n; i++) {
            cost += nums[i] * (i + 1);
        }
        return cost;
    }
}