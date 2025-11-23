class Solution {
    public int minSwaps(int minSwaps(int[][] grid) {
        int n = grid.length;
        int[] trailingZeros = new int[n];
        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = n - 1; j >= 0; j--) {
                if (grid[i][j] == 0) {
                    count++;
                } else {
                    break;
                }
            }
            trailingZeros[i] = count;
        }

        int swaps = 0;
        for (int i = 0; i < n; i++) {
            int requiredZeros = n - 1 - i;
            int j = i;
            while (j < n && trailingZeros[j] < requiredZeros) {
                j++;
            }

            if (j == n) {
                return -1;
            }

            for (int k = j; k > i; k--) {
                int temp = trailingZeros[k];
                trailingZeros[k] = trailingZeros[k - 1];
                trailingZeros[k - 1] = temp;
                swaps++;
            }
        }

        return swaps;
    }
}