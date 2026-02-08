public class Solution {

import java.util.Arrays;

public class Solution {
    public int findBestValue(int[] nums, int target) {
        Arrays.sort(nums);
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        int left = 0, right = target;
        while (left < right) {
            int mid = (left + right) / 2;
            int sum = 0;
            for (int i = 0; i < n; i++) {
                if (nums[i] > mid) {
                    sum += mid;
                } else {
                    sum += nums[i];
                }
            }
            if (sum < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int res = left;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] > res) {
                sum += res;
            } else {
                sum += nums[i];
            }
        }
        if (Math.abs(sum - target) < Math.abs(prefix[n] - target)) {
            return res;
        } else {
            return 0;
        }
    }
}
}