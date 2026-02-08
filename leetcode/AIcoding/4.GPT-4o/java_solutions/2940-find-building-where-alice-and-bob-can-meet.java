class Solution {
    public int findBuilding(int[] heights) {
        int n = heights.length;
        int[] leftMax = new int[n];
        int[] rightMax = new int[n];

        leftMax[0] = heights[0];
        for (int i = 1; i < n; i++) {
            leftMax[i] = Math.max(leftMax[i - 1], heights[i]);
        }

        rightMax[n - 1] = heights[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            rightMax[i] = Math.max(rightMax[i + 1], heights[i]);
        }

        for (int i = 0; i < n; i++) {
            if (heights[i] > leftMax[i] && heights[i] > rightMax[i]) {
                return i;
            }
        }

        return -1;
    }
}