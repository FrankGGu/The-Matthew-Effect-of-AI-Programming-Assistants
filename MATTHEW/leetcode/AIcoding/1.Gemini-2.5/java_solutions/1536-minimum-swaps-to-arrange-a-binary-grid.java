import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minSwaps(int[][] grid) {
        int n = grid.length;
        List<Integer> trailingZerosCounts = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = n - 1; j >= 0; j--) {
                if (grid[i][j] == 0) {
                    count++;
                } else {
                    break;
                }
            }
            trailingZerosCounts.add(count);
        }

        int totalSwaps = 0;

        for (int i = 0; i < n; i++) {
            int requiredTrailingZeros = n - 1 - i;

            int foundIndex = -1;
            for (int j = i; j < n; j++) {
                if (trailingZerosCounts.get(j) >= requiredTrailingZeros) {
                    foundIndex = j;
                    break;
                }
            }

            if (foundIndex == -1) {
                return -1;
            }

            totalSwaps += (foundIndex - i);

            int val = trailingZerosCounts.remove(foundIndex);
            trailingZerosCounts.add(i, val);
        }

        return totalSwaps;
    }
}