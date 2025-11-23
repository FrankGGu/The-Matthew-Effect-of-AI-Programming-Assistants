public class Solution {

import java.util.*;

public class Solution {
    public int squareFreeSubsets(int[] nums) {
        int mod = 1000000007;
        int[] dp = new int[1 << 10];
        dp[0] = 1;
        for (int num : nums) {
            if (num == 0) continue;
            int x = num;
            int square = 1;
            for (int i = 2; i * i <= x; i++) {
                int cnt = 0;
                while (x % i == 0) {
                    x /= i;
                    cnt++;
                }
                if (cnt >= 2) {
                    square = 0;
                    break;
                }
            }
            if (square == 0) continue;
            int mask = 0;
            for (int i = 2; i * i <= num; i++) {
                int cnt = 0;
                int temp = num;
                while (temp % i == 0) {
                    temp /= i;
                    cnt++;
                }
                if (cnt > 0) {
                    mask |= 1 << (i - 2);
                }
            }
            for (int i = (1 << 10) - 1; i >= 0; i--) {
                if ((i & mask) == 0) {
                    dp[i | mask] = (dp[i | mask] + dp[i]) % mod;
                }
            }
        }
        int result = 0;
        for (int i = 0; i < (1 << 10); i++) {
            result = (result + dp[i]) % mod;
        }
        return result;
    }
}
}