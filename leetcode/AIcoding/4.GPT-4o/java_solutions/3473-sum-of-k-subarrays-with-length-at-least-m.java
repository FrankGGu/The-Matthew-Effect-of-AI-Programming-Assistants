import java.util.*;

public class Solution {
    public int sumOfKSubarrays(int[] nums, int k, int m) {
        int n = nums.length;
        if (n < m) return 0;

        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int result = 0;
        for (int i = 0; i <= n - m; i++) {
            for (int j = i + m; j <= n; j++) {
                result = Math.max(result, prefixSum[j] - prefixSum[i]);
            }
        }

        return result;
    }
}