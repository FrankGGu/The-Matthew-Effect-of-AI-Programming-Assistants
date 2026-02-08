import java.util.*;

public class Solution {
    public int countWays(int[][] prevRoom) {
        int n = prevRoom.length;
        long mod = 1000000007;
        long[] dp = new long[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            int count = 0;
            for (int j : prevRoom[i - 1]) {
                count++;
            }
            dp[i] = dp[i - 1] * count % mod;
        }

        long result = dp[n];
        for (int i = 1; i <= n; i++) {
            result = result * factorial(i) % mod;
        }

        return (int) result;
    }

    private long factorial(int n) {
        long res = 1;
        for (int i = 2; i <= n; i++) {
            res = res * i % 1000000007;
        }
        return res;
    }
}