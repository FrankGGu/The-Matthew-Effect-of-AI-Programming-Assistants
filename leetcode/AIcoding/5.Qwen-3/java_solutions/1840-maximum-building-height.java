public class Solution {

import java.util.*;

public class Solution {
    public int maxBuildingHeight(int n, int[][] constraints) {
        List<int[]> constraintsList = new ArrayList<>();
        for (int[] c : constraints) {
            constraintsList.add(c);
        }
        Collections.sort(constraintsList, (a, b) -> a[0] - b[0]);
        int[] heights = new int[n];
        Arrays.fill(heights, Integer.MAX_VALUE);
        for (int i = 0; i < constraintsList.size(); i++) {
            int[] c = constraintsList.get(i);
            int pos = c[0] - 1;
            int h = c[1];
            if (heights[pos] > h) {
                heights[pos] = h;
            }
        }
        for (int i = 0; i < n - 1; i++) {
            if (heights[i] == Integer.MAX_VALUE) continue;
            int j = i + 1;
            while (j < n && heights[j] == Integer.MAX_VALUE) {
                j++;
            }
            if (j < n) {
                int dist = j - i;
                int maxH = Math.min(heights[i], heights[j]) + (j - i);
                for (int k = i + 1; k < j; k++) {
                    heights[k] = Math.min(heights[k], Math.min(heights[i] + (k - i), heights[j] + (j - k)));
                }
            }
        }
        for (int i = n - 1; i > 0; i--) {
            if (heights[i] == Integer.MAX_VALUE) continue;
            int j = i - 1;
            while (j >= 0 && heights[j] == Integer.MAX_VALUE) {
                j--;
            }
            if (j >= 0) {
                int dist = i - j;
                int maxH = Math.min(heights[i], heights[j]) + (i - j);
                for (int k = i - 1; k > j; k--) {
                    heights[k] = Math.min(heights[k], Math.min(heights[i] + (i - k), heights[j] + (k - j)));
                }
            }
        }
        int max = 0;
        for (int h : heights) {
            if (h != Integer.MAX_VALUE) {
                max = Math.max(max, h);
            }
        }
        return max;
    }
}
}