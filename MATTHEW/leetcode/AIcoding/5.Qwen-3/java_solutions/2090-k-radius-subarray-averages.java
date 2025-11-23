public class Solution {

import java.util.*;

public class Solution {
    public int[] findAverages(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n - k + 1];
        long sum = 0;
        for (int i = 0; i < k; i++) {
            sum += nums[i];
        }
        result[0] = (int) (sum / k);
        for (int i = 1; i <= n - k; i++) {
            sum = sum - nums[i - 1] + nums[i + k - 1];
            result[i] = (int) (sum / k);
        }
        return result;
    }
}
}