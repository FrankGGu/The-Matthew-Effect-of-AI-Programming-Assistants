public class Solution {

import java.util.Arrays;

public class Solution {
    public int rangeSum(int[] nums, int n, int left, int right) {
        int MOD = 1000000007;
        int[] subarrays = new int[n * (n + 1) / 2];
        int index = 0;

        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n; j++) {
                sum += nums[j];
                subarrays[index++] = sum;
            }
        }

        Arrays.sort(subarrays);

        long result = 0;
        for (int i = left - 1; i < right; i++) {
            result = (result + subarrays[i]) % MOD;
        }

        return (int) result;
    }
}
}