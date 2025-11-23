class Solution {
    public long distributeCandies(int n, int limit) {
        return comb(n + 2) - 3 * comb(n - limit + 1) + 3 * comb(n - 2 * limit);
    }

    private long comb(int x) {
        if (x < 2) return 0;
        return (long) x * (x - 1) / 2;
    }
}