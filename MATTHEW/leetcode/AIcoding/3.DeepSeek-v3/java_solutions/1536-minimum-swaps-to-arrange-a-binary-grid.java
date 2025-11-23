class Solution {
    public int minSwaps(int[][] grid) {
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
            int required = n - 1 - i;
            int current = i;

            while (current < n && trailingZeros[current] < required) {
                current++;
            }

            if (current == n) {
                return -1;
            }

            while (current > i) {
                int temp = trailingZeros[current];
                trailingZeros[current] = trailingZeros[current - 1];
                trailingZeros[current - 1] = temp;
                current--;
                swaps++;
            }
        }

        return swaps;
    }
}