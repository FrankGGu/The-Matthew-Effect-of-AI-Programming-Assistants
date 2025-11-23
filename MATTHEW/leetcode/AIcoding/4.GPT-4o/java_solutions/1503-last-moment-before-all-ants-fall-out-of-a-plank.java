public class Solution {
    public int getLastMoment(int n, int[] left, int[] right) {
        int maxLeft = left.length > 0 ? Integer.MIN_VALUE : 0;
        int maxRight = right.length > 0 ? Integer.MIN_VALUE : 0;

        for (int l : left) {
            maxLeft = Math.max(maxLeft, l);
        }

        for (int r : right) {
            maxRight = Math.max(maxRight, n - r);
        }

        return Math.max(maxLeft, maxRight);
    }
}