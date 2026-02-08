class Solution {
    private static final int MOD = 1_000_000_007;

    public int numDecodings(String s) {
        int n = s.length();

        long a = 1; // Corresponds to dp[i-2] (number of ways for string of length i-2)
        long b;     // Corresponds to dp[i-1] (number of ways for string of length i-1)

        char firstChar = s.charAt(0);
        if (firstChar == '0') {
            b = 0;
        } else if (firstChar == '*') {
            b = 9;
        } else {
            b = 1;
        }

        for (int i = 1; i < n; i++) {
            char c1 = s.charAt(i);   // current character (s[i])
            char c2 = s.charAt(i - 1); // previous character (s[i-1])

            long current_dp = 0;

            // Ways from decoding s[i] as a single digit
            current_dp = (current_dp + b * waysSingle(c1)) % MOD;

            // Ways from decoding s[i-1]s[i] as a two-digit number
            current_dp = (current_dp + a * waysTwo(c2, c1)) % MOD;

            a = b;
            b = current_dp;
        }

        return (int) b;
    }

    private long waysSingle(char c) {
        if (c == '0') {
            return 0;
        }
        if (c == '*') {
            return 9; // '*' can be '1' through '9'
        }
        return 1; // '1' through '9'
    }

    private long waysTwo(char c1, char c2) {
        if (c1 == '0') {
            return 0; // "0X" is invalid
        }
        if (c1 == '1') {
            if (c2 == '*') {
                return 9; // "1*" can be "11" through "19" (9 ways)
            }
            return 1; // "10" through "19" (1 way for each specific digit)
        }
        if (c1 == '2') {
            if (c2 == '*') {
                return 6; // "2*" can be "21" through "26" (6 ways)
            }
            if (c2 >= '0' && c2 <= '6') {
                return 1; // "20" through "26" (1 way for each specific digit)
            }
            return 0; // "27" through "29" (invalid)
        }
        if (c1 == '*') {
            if (c2 == '*') {
                return 15; // "1*" (9 ways) + "2*" (6 ways)
            }
            if (c2 >= '0' && c2 <= '6') {
                return 2; // "*c2" where c2 is 0-6: "1c2" (1 way) or "2c2" (1 way)
            }
            if (c2 >= '7' && c2 <= '9') {
                return 1; // "*c2" where c2 is 7-9: only "1c2" (1 way)
            }
        }
        return 0; // For c1 >= '3' and not '*'
    }
}