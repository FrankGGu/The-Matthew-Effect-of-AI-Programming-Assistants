class Solution {
    public int getLastMoment(int n, int[] left, int[] right) {
        int maxLeft = 0;
        int maxRight = 0;

        for (int num : left) {
            maxLeft = Math.max(maxLeft, num);
        }

        for (int num : right) {
            maxRight = Math.max(maxRight, n - num);
        }

        return Math.max(maxLeft, maxRight);
    }
}