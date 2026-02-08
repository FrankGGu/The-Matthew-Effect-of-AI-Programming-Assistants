public class Solution {

import java.util.*;

public class Solution {
    public int strongPasswordChecker(String password) {
        boolean hasLower = false, hasUpper = false, hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isDigit(c)) hasDigit = true;
        }
        int missing = 3 - (hasLower ? 1 : 0) - (hasUpper ? 1 : 0) - (hasDigit ? 1 : 0);
        int n = password.length();
        if (n < 6) {
            return Math.max(missing, 6 - n);
        } else if (n <= 20) {
            int replace = 0;
            int[] count = new int[3];
            char[] s = password.toCharArray();
            for (int i = 0; i < n; ) {
                char c = s[i];
                int j = i;
                while (j < n && s[j] == c) j++;
                int len = j - i;
                if (len >= 3) {
                    replace += len / 3;
                }
                i = j;
            }
            return Math.max(missing, replace);
        } else {
            int replace = 0;
            int[] count = new int[3];
            char[] s = password.toCharArray();
            for (int i = 0; i < n; ) {
                char c = s[i];
                int j = i;
                while (j < n && s[j] == c) j++;
                int len = j - i;
                if (len >= 3) {
                    replace += len / 3;
                }
                i = j;
            }
            int[] dp = new int[3];
            int[] remove = new int[3];
            for (int i = 0; i < n; ) {
                char c = s[i];
                int j = i;
                while (j < n && s[j] == c) j++;
                int len = j - i;
                if (len >= 3) {
                    int mod = len % 3;
                    dp[mod]++;
                }
                i = j;
            }
            int removeCount = n - 20;
            for (int i = 0; i < 3 && removeCount > 0; i++) {
                int use = Math.min(dp[i], removeCount);
                removeCount -= use;
                dp[i] -= use;
            }
            int replace2 = 0;
            for (int i = 0; i < 3; i++) {
                replace2 += dp[i] * i;
            }
            return (n - 20) + Math.max(missing, replace2);
        }
    }
}
}