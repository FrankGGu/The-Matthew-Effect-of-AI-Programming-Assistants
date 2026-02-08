public class Solution {

import java.util.*;

public class Solution {
    public int arrangeClothes(int[] clothes, int k) {
        Arrays.sort(clothes);
        int n = clothes.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (i - j <= k) {
                    int cost = clothes[i] - clothes[j];
                    if (j == 0) {
                        dp[i] = Math.min(dp[i], cost);
                    } else {
                        dp[i] = Math.min(dp[i], dp[j - 1] + cost);
                    }
                }
            }
        }

        return dp[n - 1];
    }
}
}