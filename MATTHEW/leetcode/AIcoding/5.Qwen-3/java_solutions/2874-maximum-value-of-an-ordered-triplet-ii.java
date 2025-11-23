public class Solution {

import java.util.*;

public class Solution {
    public int maximumTripletValue(int[] nums) {
        int n = nums.length;
        int[] maxRight = new int[n];
        Arrays.fill(maxRight, Integer.MIN_VALUE);

        for (int i = n - 2; i >= 0; i--) {
            maxRight[i] = Math.max(nums[i + 1], maxRight[i + 1]);
        }

        int result = Integer.MIN_VALUE;
        int[] prefixMax = new int[n];
        prefixMax[0] = nums[0];

        for (int i = 1; i < n; i++) {
            prefixMax[i] = Math.max(prefixMax[i - 1], nums[i]);
        }

        for (int i = 0; i < n; i++) {
            if (i + 1 < n && maxRight[i] != Integer.MIN_VALUE) {
                int a = prefixMax[i];
                int b = nums[i];
                int c = maxRight[i];
                result = Math.max(result, a - b + c);
            }
        }

        return result == Integer.MIN_VALUE ? 0 : result;
    }
}
}