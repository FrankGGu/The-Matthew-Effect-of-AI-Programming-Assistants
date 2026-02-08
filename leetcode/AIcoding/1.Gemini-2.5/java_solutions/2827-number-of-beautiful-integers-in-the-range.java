class Solution {
    long[][][][][][] memo;
    String S;
    int K;

    public int numberOfBeautifulIntegers(int low, int high, int k) {
        K = k;
        return (int) (countBeautiful(high) - countBeautiful(low - 1));
    }

    private long countBeautiful(long n) {
        S = String.valueOf(n);
        // idx, tight, isLeadingZero, evenCount, oddCount, currentModK
        memo = new long[S.length()][2][2][S.length() + 1][S.length() + 1][K];
        for (int i = 0; i < S.length(); i++) {
            for (int j = 0; j < 2; j++) {
                for (int l = 0; l < 2; l++) {
                    for (int m = 0; m <= S.length(); m++) {
                        for (int o = 0; o <= S.length(); o++) {
                            for (int p = 0; p < K; p++) {
                                memo[i][j][l][m][o][p] = -1;
                            }
                        }
                    }
                }
            }
        }
        return dp(0, true, true, 0, 0, 0);
    }

    private long dp(int idx, boolean tight, boolean isLeadingZero, int evenCount, int oddCount, int currentModK) {
        if (idx == S.length()) {
            return (evenCount == oddCount && evenCount > 0 && currentModK == 0) ? 1 : 0;
        }

        if (memo[idx][tight ? 1 : 0][isLeadingZero ? 1 : 0][evenCount][oddCount][currentModK] != -1) {
            return memo[idx][tight ? 1 : 0][isLeadingZero ? 1 : 0][evenCount][oddCount][currentModK];
        }

        long ans = 0;
        int upperLimit = tight ? (S.charAt(idx) - '0') : 9;

        for (int digit = 0; digit <= upperLimit; digit++) {
            if (isLeadingZero && digit == 0) {
                ans += dp(idx + 1, tight && (digit == upperLimit), true, evenCount, oddCount, currentModK);
            } else {
                int newEvenCount = evenCount;
                int newOddCount = oddCount;
                if (digit % 2 == 0) {
                    newEvenCount++;
                } else {
                    newOddCount++;
                }
                int newModK = (currentModK * 10 + digit) % K;
                ans += dp(idx + 1, tight && (digit == upperLimit), false, newEvenCount, newOddCount, newModK);
            }
        }

        return memo[idx][tight ? 1 : 0][isLeadingZero ? 1 : 0][evenCount][oddCount][currentModK] = ans;
    }
}