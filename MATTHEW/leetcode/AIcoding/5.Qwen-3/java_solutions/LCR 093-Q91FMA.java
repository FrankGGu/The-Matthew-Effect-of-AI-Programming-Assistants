public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int lenLongestFibSubseq(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            indexMap.put(nums[i], i);
        }
        int[][] dp = new int[n][n];
        int maxLen = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                int prev = nums[i] - nums[j];
                if (indexMap.containsKey(prev)) {
                    int k = indexMap.get(prev);
                    dp[j][i] = dp[k][j] + 1;
                    maxLen = Math.max(maxLen, dp[j][i]);
                }
            }
        }
        return maxLen;
    }
}
}