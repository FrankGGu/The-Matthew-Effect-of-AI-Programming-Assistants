public class Solution {

import java.util.*;

public class Solution {
    public double new21Game(int N, int K, int maxPts) {
        if (K == 0) return 1.0;
        double[] dp = new double[N + 1];
        dp[0] = 1.0;
        double windowSum = 1.0;
        for (int i = 1; i <= N; i++) {
            if (i - 1 >= K) {
                windowSum -= dp[i - 1 - maxPts];
            }
            dp[i] = windowSum;
            if (i < K) {
                windowSum += dp[i];
            }
        }
        double result = 0.0;
        for (int i = K; i <= N; i++) {
            result += dp[i];
        }
        return result;
    }
}
}