public class Solution {

import java.util.*;

public class Solution {
    public long[] sortedKSubarraysPower(int[] nums, int k) {
        int n = nums.length;
        long[] result = new long[n - k + 1];

        for (int i = 0; i <= n - k; i++) {
            int[] sub = Arrays.copyOfRange(nums, i, i + k);
            Arrays.sort(sub);
            long power = 0;
            for (int j = 0; j < k; j++) {
                power += (long) Math.pow(sub[j], j + 1);
            }
            result[i] = power;
        }

        return result;
    }
}
}