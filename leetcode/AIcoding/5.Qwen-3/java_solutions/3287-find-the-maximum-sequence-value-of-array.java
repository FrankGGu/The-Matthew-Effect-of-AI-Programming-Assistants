public class Solution {

import java.util.*;

public class Solution {
    public int maximumValue(int[] nums, int[] index) {
        int n = nums.length;
        int[] result = new int[n];
        Arrays.fill(result, 0);

        for (int i = 0; i < n; i++) {
            int idx = index[i];
            result[idx] = Math.max(result[idx], nums[i]);
        }

        int max = 0;
        for (int val : result) {
            max = Math.max(max, val);
        }

        return max;
    }
}
}