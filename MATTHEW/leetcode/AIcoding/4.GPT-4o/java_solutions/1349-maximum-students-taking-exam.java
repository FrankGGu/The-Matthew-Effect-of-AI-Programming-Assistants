class Solution {
    public int maxStudents(char[][] seats) {
        int m = seats.length, n = seats[0].length;
        int[] dp = new int(1 << n);
        for (int i = 0; i < m; i++) {
            int[] newDp = new int(1 << n);
            for (int j = 0; j < (1 << n); j++) {
                if (dp[j] == 0 && j != 0) continue;
                for (int k = 0; k < (1 << n); k++) {
                    if ((j & k) == 0 && isValid(seats[i], k)) {
                        newDp[k] = Math.max(newDp[k], dp[j] + Integer.bitCount(k));
                    }
                }
            }
            dp = newDp;
        }
        int res = 0;
        for (int j = 0; j < (1 << n); j++) {
            res = Math.max(res, dp[j]);
        }
        return res;
    }

    private boolean isValid(char[] row, int mask) {
        for (int i = 0; i < row.length; i++) {
            if ((mask & (1 << i)) != 0) {
                if (row[i] == '#') return false;
                if (i > 0 && (mask & (1 << (i - 1))) != 0) return false;
            }
        }
        return true;
    }
}