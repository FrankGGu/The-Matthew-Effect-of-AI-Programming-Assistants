import java.util.Arrays;

class Solution {
    public int maxStudents(char[][] seats) {
        int m = seats.length;
        int n = seats[0].length;

        int[] seatableRowMasks = new int[m];
        for (int i = 0; i < m; i++) {
            int mask = 0;
            for (int j = 0; j < n; j++) {
                if (seats[i][j] == '.') {
                    mask |= (1 << j);
                }
            }
            seatableRowMasks[i] = mask;
        }

        int[][] dp = new int[m][1 << n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dp[i], -1);
        }

        for (int currentMask = 0; currentMask < (1 << n); currentMask++) {
            if (isValidPlacement(currentMask, seatableRowMasks[0])) {
                dp[0][currentMask] = countSetBits(currentMask);
            }
        }

        for (int i = 1; i < m; i++) {
            for (int currentMask = 0; currentMask < (1 << n); currentMask++) {
                if (!isValidPlacement(currentMask, seatableRowMasks[i])) {
                    continue;
                }

                int studentsInCurrentRow = countSetBits(currentMask);

                for (int prevMask = 0; prevMask < (1 << n); prevMask++) {
                    if (dp[i - 1][prevMask] != -1) {
                        if (isCompatible(currentMask, prevMask)) {
                            dp[i][currentMask] = Math.max(dp[i][currentMask], dp[i - 1][prevMask] + studentsInCurrentRow);
                        }
                    }
                }
            }
        }

        int maxStudents = 0;
        for (int mask = 0; mask < (1 << n); mask++) {
            maxStudents = Math.max(maxStudents, dp[m - 1][mask]);
        }

        return maxStudents;
    }

    private boolean isValidPlacement(int mask, int seatableRowMask) {
        return (mask & (mask << 1)) == 0 && ((mask & (~seatableRowMask)) == 0);
    }

    private boolean isCompatible(int currentMask, int prevMask) {
        return (currentMask & (prevMask << 1)) == 0 && (currentMask & (prevMask >> 1)) == 0;
    }

    private int countSetBits(int n) {
        int count = 0;
        while (n > 0) {
            n &= (n - 1);
            count++;
        }
        return count;
    }
}