public class Solution {

import java.util.*;

public class Solution {
    public int[] kSum(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n - k + 1];
        for (int i = 0; i <= n - k; i++) {
            int sum = 0;
            for (int j = 0; j < k; j++) {
                sum += nums[i + j];
            }
            result[i] = sum;
        }
        return result;
    }
}
}