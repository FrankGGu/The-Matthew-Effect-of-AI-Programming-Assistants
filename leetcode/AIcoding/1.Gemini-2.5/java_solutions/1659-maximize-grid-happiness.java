class Solution {
    int m, n;
    int[][][][] memo;
    int[] powersOf3;

    final int EMPTY = 0;
    final int INTROVERT = 1;
    final int EXTROVERT = 2;

    final int H_BASE_I = 120;
    final int H_BASE_E = 40;
    final int H_SAME = -60;
    final int H_DIFF = -10;

    public int getMaxGridHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
        this.m = m;
        this.n = n;

        powersOf3 = new int[n + 1];
        powersOf3[0] = 1;
        for (int i = 1; i <= n; i++) {
            powersOf3[i] = powersOf3[i - 1] * 3;
        }

        int maxMask = powersOf3[n]; // 3^n
        memo = new int[m][maxMask][introvertsCount + 1][extrovertsCount + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < maxMask; j++) {
                for (int k = 0; k <= introvertsCount; k++) {
                    for (int l = 0; l <= extrovertsCount; l++) {
                        memo[i][j][k][l] = -1; // Initialize with -1 to indicate not computed
                    }
                }
            }
        }

        return solve(0, 0, introvertsCount, extrovertsCount);
    }

    // r: current row index
    // prevMask: bitmask representing the state of the previous row (row r-1)
    // iCount: number of introverts remaining to place
    // eCount: number of extroverts remaining to place
    private int solve(int r, int prevMask, int iCount, int eCount) {
        if (r == m) {
            return 0;
        }
        if (memo[r][prevMask][iCount][eCount] != -1) {
            return memo[r][prevMask][iCount][eCount];
        }

        int maxHappiness = Integer.MIN_VALUE; 

        // Iterate over all possible configurations for the current row r
        // currMask represents the state of cells in the current row r
        for (int currMask = 0; currMask < powersOf3[n]; currMask++) {
            int currentHappiness = 0;
            int introvertsUsedInRow = 0;
            int extrovertsUsedInRow = 0;

            for (int c = 0; c < n; c++) {
                int personType = (currMask / powersOf3[c]) % 3;

                if (personType == INTROVERT) {
                    introvertsUsedInRow++;
                    currentHappiness += H_BASE_I;
                } else if (personType == EXTROVERT) {
                    extrovertsUsedInRow++;
                    currentHappiness += H_BASE_E;
                }

                // Check horizontal interaction with the cell to the left
                if (c > 0) {
                    int leftPersonType = (currMask / powersOf3[c - 1]) % 3;
                    if (personType != EMPTY && leftPersonType != EMPTY) {
                        if (personType == leftPersonType) {
                            currentHappiness += H_SAME;
                        } else {
                            currentHappiness += H_DIFF;
                        }
                    }
                }

                // Check vertical interaction with the cell above (in prevMask)
                int abovePersonType = (prevMask / powersOf3[c]) % 3;
                if (personType != EMPTY && abovePersonType != EMPTY) {
                    if (personType == abovePersonType) {
                        currentHappiness += H_SAME;
                    } else {
                        currentHappiness += H_DIFF;
                    }
                }
            }

            if (introvertsUsedInRow <= iCount && extrovertsUsedInRow <= eCount) {
                maxHappiness = Math.max(maxHappiness, currentHappiness + solve(r + 1, currMask, iCount - introvertsUsedInRow, eCount - extrovertsUsedInRow));
            }
        }

        return memo[r][prevMask][iCount][eCount] = maxHappiness;
    }
}