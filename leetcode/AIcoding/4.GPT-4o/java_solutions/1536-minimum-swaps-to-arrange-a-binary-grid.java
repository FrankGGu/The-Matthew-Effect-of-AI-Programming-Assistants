class Solution {
    public int minSwaps(int[][] grid) {
        int n = grid.length;
        int[] zeroCount = new int[n];

        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = n - 1; j >= 0; j--) {
                if (grid[i][j] == 1) break;
                count++;
            }
            zeroCount[i] = count;
        }

        int swaps = 0;
        for (int i = 0; i < n; i++) {
            int required = n - 1 - i;
            int j = i;
            while (j < n && zeroCount[j] < required) {
                j++;
            }
            if (j == n) return -1;
            for (int k = j; k > i; k--) {
                int temp = zeroCount[k];
                zeroCount[k] = zeroCount[k - 1];
                zeroCount[k - 1] = temp;
                swaps++;
            }
        }

        return swaps;
    }
}