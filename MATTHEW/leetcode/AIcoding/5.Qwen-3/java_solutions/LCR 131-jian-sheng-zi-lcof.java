public class Solution {

import java.util.*;

public class Solution {
    public int cut竹子(int[] rods) {
        Arrays.sort(rods);
        int n = rods.length;
        int[] dp = new int[n];
        dp[0] = rods[0];
        for (int i = 1; i < n; i++) {
            dp[i] = dp[i - 1] + rods[i];
        }
        return dp[n - 1];
    }
}
}