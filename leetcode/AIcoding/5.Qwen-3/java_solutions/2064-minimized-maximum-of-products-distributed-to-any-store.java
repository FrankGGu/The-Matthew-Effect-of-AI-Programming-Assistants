public class Solution {

import java.util.*;

public class Solution {
    public int minimizeMax(int[] nums, int k) {
        Arrays.sort(nums);
        int left = 0, right = nums[nums.length - 1] - nums[0];

        while (left < right) {
            int mid = (left + right) / 2;
            if (canDistribute(nums, k, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canDistribute(int[] nums, int k, int maxDiff) {
        int count = 1;
        int prev = nums[0];

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] - prev > maxDiff) {
                count++;
                prev = nums[i];
                if (count > k) {
                    return false;
                }
            }
        }
        return true;
    }
}
}