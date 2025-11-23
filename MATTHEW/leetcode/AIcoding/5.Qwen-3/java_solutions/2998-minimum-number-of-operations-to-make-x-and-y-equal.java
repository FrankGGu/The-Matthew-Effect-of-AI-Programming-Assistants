public class Solution {

import java.util.*;

public class Solution {
    public int minimumOperationsToMakeXAndYEqual(int[] nums, int x, int y) {
        int n = nums.length;
        int[] diff = new int[n];
        for (int i = 0; i < n; i++) {
            diff[i] = nums[i] - x;
        }
        Arrays.sort(diff);
        int res = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int target = y - x;
            int left = 0;
            int right = n - 1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (diff[mid] <= target) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            int count = left;
            int cost = 0;
            for (int j = 0; j < count; j++) {
                cost += Math.abs(diff[j]);
            }
            res = Math.min(res, cost);
        }
        return res;
    }
}
}