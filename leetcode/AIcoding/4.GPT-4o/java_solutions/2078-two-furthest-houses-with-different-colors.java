class Solution {
    public int maxDistance(int[] colors) {
        int n = colors.length;
        int leftColor = colors[0], rightColor = colors[n - 1];

        int maxDistance = 0;

        for (int i = 0; i < n; i++) {
            if (colors[i] != leftColor) {
                maxDistance = Math.max(maxDistance, i);
            }
            if (colors[i] != rightColor) {
                maxDistance = Math.max(maxDistance, n - 1 - i);
            }
        }

        return maxDistance;
    }
}