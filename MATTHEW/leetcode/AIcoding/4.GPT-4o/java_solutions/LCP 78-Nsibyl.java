public class Solution {
    public int findMinHeightShelters(int[][] heights) {
        int n = heights.length;
        if (n == 0) return 0;

        Arrays.sort(heights, (a, b) -> a[1] - b[1]);
        int count = 0;
        int lastHeight = 0;

        for (int[] height : heights) {
            if (height[0] > lastHeight) {
                count++;
                lastHeight = height[1];
            }
        }

        return count;
    }
}