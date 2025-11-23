import java.util.Arrays;

public class Solution {
    public long minCost(int[] nums1, int[] nums2, int[] cost) {
        int n = nums1.length;
        long low = 0, high = (long) 1e9, ans = 0;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (canMakeIdentical(nums1, nums2, cost, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    private boolean canMakeIdentical(int[] nums1, int[] nums2, int[] cost, long target) {
        long totalCost = 0;
        for (int i = 0; i < nums1.length; i++) {
            if (nums1[i] < target) {
                totalCost += (target - nums1[i]) * cost[i];
            } else if (nums1[i] > target) {
                totalCost -= (nums1[i] - target) * cost[i];
            }
            if (totalCost < 0) return false;
        }
        return true;
    }
}