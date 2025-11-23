public class Solution {

import java.util.*;

public class Solution {
    public int findIntegers(int n) {
        List<Integer> bits = new ArrayList<>();
        while (n > 0) {
            bits.add(n % 2);
            n /= 2;
        }
        int m = bits.size();
        int[] dp = new int[m + 1];
        dp[0] = 1;
        dp[1] = 1;
        for (int i = 2; i < m + 1; i++) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        int result = 0;
        for (int i = 0; i < m; i++) {
            if (bits.get(i) == 1) {
                result += dp[m - i - 1];
                if (i > 0 && bits.get(i - 1) == 1) {
                    return result;
                }
            }
        }
        return result + 1;
    }
}
}