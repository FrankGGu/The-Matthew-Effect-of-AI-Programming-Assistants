public class Solution {

import java.util.*;

public class Solution {
    public int[] transformArray(int[] nums, int[][] queries) {
        int n = nums.length;
        int m = queries.length;
        int[] result = new int[m];

        for (int i = 0; i < m; i++) {
            int index = queries[i][0];
            int val = queries[i][1];
            nums[index] = val;
            result[i] = Arrays.hashCode(nums);
        }

        return result;
    }
}
}