class Solution {
    public long minimumSeconds(int[] h) {
        long totalSeconds = 0;
        int n = h.length;
        for (int i = 0; i < n; i++) {
            if (h[i] > 0) {
                int left = (i > 0) ? h[i - 1] : 0;
                int right = (i < n - 1) ? h[i + 1] : 0;
                int decrease = Math.max(0, h[i] - Math.max(left, right));
                totalSeconds += (long) h[i] - decrease;
            }
        }
        return totalSeconds;
    }
}