public class Solution {

import java.util.*;

public class Solution {
    public int sumOfBeauty(int[] nums, int k) {
        int n = nums.length;
        int[] left = new int[n];
        int[] right = new int[n];

        Arrays.fill(left, 1);
        Arrays.fill(right, 1);

        for (int i = 1; i < n; i++) {
            if (nums[i] > nums[i - 1]) {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 1;
            }
        }

        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] > nums[i + 1]) {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 1;
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            int beauty = Math.min(left[i], right[i]);
            if (beauty > k) {
                result += k;
            } else {
                result += beauty;
            }
        }

        return result;
    }
}
}