import java.util.Arrays;

class Solution {
    public int maximizeTowerHeights(int[] heights) {
        Arrays.sort(heights);
        int n = heights.length;
        int[] diff = new int[n];
        diff[0] = 0;
        for (int i = 1; i < n; i++) {
            diff[i] = Math.max(0, heights[i - 1] + 1 - heights[i]);
        }
        for (int i = 1; i < n; i++) {
            diff[i] += diff[i - 1];
            heights[i] += diff[i];
        }
        int sum = 0;
        for (int h : heights) {
            sum += h;
        }
        return sum;
    }
}