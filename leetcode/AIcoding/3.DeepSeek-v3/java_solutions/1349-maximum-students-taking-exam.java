class Solution {
    public int maxStudents(char[][] seats) {
        int m = seats.length;
        int n = seats[0].length;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, -1);
        dp[0] = 0;

        for (int i = 0; i < m; i++) {
            int[] newDp = new int[1 << n];
            Arrays.fill(newDp, -1);
            for (int prevMask = 0; prevMask < (1 << n); prevMask++) {
                if (dp[prevMask] == -1) continue;
                for (int currMask = 0; currMask < (1 << n); currMask++) {
                    if (isValid(seats, i, prevMask, currMask)) {
                        newDp[currMask] = Math.max(newDp[currMask], dp[prevMask] + Integer.bitCount(currMask));
                    }
                }
            }
            dp = newDp;
        }

        int max = 0;
        for (int num : dp) {
            max = Math.max(max, num);
        }
        return max;
    }

    private boolean isValid(char[][] seats, int row, int prevMask, int currMask) {
        int n = seats[0].length;
        for (int j = 0; j < n; j++) {
            if ((currMask & (1 << j)) == 0) continue;
            if (seats[row][j] == '#') return false;
            if (j > 0 && (currMask & (1 << (j - 1))) != 0) return false;
            if (j < n - 1 && (currMask & (1 << (j + 1))) != 0) return false;
            if (j > 0 && row > 0 && (prevMask & (1 << (j - 1))) != 0) return false;
            if (j < n - 1 && row > 0 && (prevMask & (1 << (j + 1))) != 0) return false;
        }
        return true;
    }
}