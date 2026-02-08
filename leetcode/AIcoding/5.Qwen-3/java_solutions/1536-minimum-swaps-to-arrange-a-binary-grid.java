public class Solution {

import java.util.*;

public class Solution {
    public int minSwapsToArrangeBinaryGrid(int[][] grid) {
        int n = grid.length;
        int[] rowHeights = new int[n];

        for (int i = 0; i < n; i++) {
            int height = 0;
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    height = n - j;
                }
            }
            rowHeights[i] = height;
        }

        Arrays.sort(rowHeights);

        int swaps = 0;
        for (int i = 0; i < n; i++) {
            int target = n - i;
            int j = i;
            while (j < n && rowHeights[j] < target) {
                j++;
            }
            if (j == n) {
                return -1;
            }
            while (j > i) {
                int temp = rowHeights[j];
                rowHeights[j] = rowHeights[j - 1];
                rowHeights[j - 1] = temp;
                j--;
                swaps++;
            }
        }

        return swaps;
    }
}
}