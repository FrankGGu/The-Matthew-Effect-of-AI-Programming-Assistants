public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int res = n;
        int j = 0;
        for (int i = 0; i < n; i++) {
            while (j < n && nums[j] - nums[i] <= n - 1) {
                j++;
            }
            res = Math.min(res, n - (j - i));
        }
        return res;
    }
}
}