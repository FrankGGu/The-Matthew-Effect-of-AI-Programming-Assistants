public class Solution {

import java.util.Arrays;

public class Solution {
    public int minCostToMakeArrayEqualindromic(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int mid = n / 2;
        int median = nums[mid];
        int cost = 0;
        for (int num : nums) {
            cost += Math.abs(num - median);
        }
        return cost;
    }
}
}