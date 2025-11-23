class Solution {
    public int findTheChild(int n, int k) {
        if (n == 1) {
            return 0;
        }

        int cycleLength = 2 * (n - 1);
        int effectiveK = k % cycleLength;

        if (effectiveK < n) {
            return effectiveK;
        } else {
            // The ball is moving backward
            // It reached n-1 at k = n-1.
            // effectiveK - (n-1) is how many steps it moved backward from n-1.
            return (n - 1) - (effectiveK - (n - 1));
        }
    }
}