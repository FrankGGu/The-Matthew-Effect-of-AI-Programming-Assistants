class Solution {
    public long coloredCells(int n) {
        long N = n;
        return 2 * N * N - 2 * N + 1;
    }
}