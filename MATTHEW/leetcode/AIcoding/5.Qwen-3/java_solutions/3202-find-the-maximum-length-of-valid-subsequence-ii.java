public class Solution {

import java.util.*;

public class Solution {
    public int findMaximumLength(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        int[] prev = new int[n];
        Arrays.fill(prev, -1);
        int[] maxLen = new int[n];
        int[] sum = new int[n];

        for (int i = 0; i < n; i++) {
            dp[i] = 1;
            maxLen[i] = 1;
            sum[i] = nums[i];
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i] && dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                    maxLen[i] = maxLen[j] + 1;
                    sum[i] = sum[j] + nums[i];
                }
            }
        }

        int maxIndex = 0;
        for (int i = 1; i < n; i++) {
            if (maxLen[i] > maxLen[maxIndex]) {
                maxIndex = i;
            }
        }

        int res = 0;
        int current = maxIndex;
        while (current != -1) {
            res++;
            current = prev[current];
        }

        return res;
    }
}
}