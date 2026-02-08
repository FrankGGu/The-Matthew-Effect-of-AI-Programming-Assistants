class Solution {
    public int minTaps(int n, int[] ranges) {
        int[] maxRange = new int[n + 1];
        for (int i = 0; i <= n; i++) {
            int left = Math.max(0, i - ranges[i]);
            int right = Math.min(n, i + ranges[i]);
            maxRange[left] = Math.max(maxRange[left], right);
        }

        int taps = 0, farthest = 0, currEnd = 0;
        for (int i = 0; i < n; i++) {
            farthest = Math.max(farthest, maxRange[i]);
            if (i == currEnd) {
                taps++;
                currEnd = farthest;
                if (currEnd >= n) {
                    return taps;
                }
            }
            if (farthest <= i) {
                return -1;
            }
        }
        return -1;
    }
}