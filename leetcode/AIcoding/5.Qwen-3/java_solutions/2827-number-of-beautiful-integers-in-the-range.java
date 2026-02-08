public class Solution {

import java.util.*;

public class Solution {
    public int numberOfBeautifulIntegers(int k) {
        int[] dp = new int[10];
        dp[0] = 1;
        for (int i = 1; i <= 9; i++) {
            dp[i] = dp[i - 1] * (i + 1);
        }
        int res = 0;
        for (int i = 1; i <= k; i++) {
            String s = Integer.toString(i);
            if (isBeautiful(s)) {
                res++;
            }
        }
        return res;
    }

    private boolean isBeautiful(String s) {
        int n = s.length();
        int[] count = new int[10];
        for (char c : s.toCharArray()) {
            count[c - '0']++;
        }
        for (int i = 0; i < 10; i++) {
            if (count[i] > 0 && count[i] % 2 == 1) {
                return false;
            }
        }
        return true;
    }
}
}