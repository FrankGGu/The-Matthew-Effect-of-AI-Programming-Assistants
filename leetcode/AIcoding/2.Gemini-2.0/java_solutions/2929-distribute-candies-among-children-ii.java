class Solution {
    public long distributeCandies(int n, int limit) {
        long ans = 0;
        for (int i = 0; i <= Math.min(limit, n); i++) {
            int remaining = n - i;
            long maxPossible = Math.min(limit, remaining);
            long minPossible = Math.max(0, remaining - limit);
            if (maxPossible >= minPossible) {
                ans += maxPossible - minPossible + 1;
            }
        }
        return ans;
    }
}