class Solution {
    int n;
    int[][] grid;

    public int minFlips(int[][] grid) {
        this.grid = grid;
        this.n = grid.length;
        int minFlips = Integer.MAX_VALUE;
        for (int mask = 0; mask < (1 << n); mask++) {
            int flips = 0;
            int[][] tempGrid = new int[n][n];
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    tempGrid[i][j] = grid[i][j];
                }
            }

            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    flips++;
                    for (int j = 0; j < n; j++) {
                        tempGrid[i][j] = 1 - tempGrid[i][j];
                    }
                }
            }

            boolean isPalindrome = true;
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n / 2; j++) {
                    if (tempGrid[i][j] != tempGrid[i][n - 1 - j]) {
                        isPalindrome = false;
                        break;
                    }
                }
                if (!isPalindrome) break;
            }

            if (isPalindrome) {
                minFlips = Math.min(minFlips, flips);
            }
        }

        return minFlips == Integer.MAX_VALUE ? -1 : minFlips;
    }
}