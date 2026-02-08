class Solution {
    public int antOnBoundary(int n, int t) {
        return (t % (2 * n) <= n) ? t % (2 * n) : 2 * n - (t % (2 * n));
    }
}