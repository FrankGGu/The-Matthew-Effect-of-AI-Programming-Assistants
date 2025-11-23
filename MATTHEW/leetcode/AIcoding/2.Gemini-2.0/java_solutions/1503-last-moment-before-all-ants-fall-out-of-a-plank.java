class Solution {
    public int getLastMoment(int n, int[] left, int[] right) {
        int maxLeft = 0;
        for (int pos : left) {
            maxLeft = Math.max(maxLeft, pos);
        }
        int minRight = n;
        if (right.length > 0) {
            minRight = right[0];
            for (int i = 1; i < right.length; i++) {
                minRight = Math.min(minRight, right[i]);
            }
        } else {
            minRight = n + 1;
        }

        int timeLeft = maxLeft;
        int timeRight = n - minRight;

        return Math.max(timeLeft, timeRight);
    }
}