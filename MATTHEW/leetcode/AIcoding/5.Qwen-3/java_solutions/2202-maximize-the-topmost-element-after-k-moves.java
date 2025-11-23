public class Solution {

import java.util.*;

public class Solution {
    public int maximumTop(int[] nums, int k) {
        int n = nums.length;
        if (k == 0) {
            return nums[0];
        }
        if (n == 1) {
            return k % 2 == 0 ? nums[0] : -1;
        }
        if (k >= n) {
            return Arrays.stream(nums).max().getAsInt();
        }
        int max = -1;
        for (int i = 0; i < k - 1; i++) {
            max = Math.max(max, nums[i]);
        }
        max = Math.max(max, nums[k]);
        return max;
    }
}
}