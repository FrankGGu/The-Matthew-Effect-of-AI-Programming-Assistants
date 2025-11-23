class Solution {
    public int longestPushTime(int[] pushTimes, int k) {
        int n = pushTimes.length;
        int maxTime = 0;
        for (int i = 0; i < n; i++) {
            int start = Math.max(0, i - k + 1);
            int end = i;
            maxTime = Math.max(maxTime, pushTimes[end] - (start > 0 ? pushTimes[start - 1] : 0));
        }
        return maxTime;
    }
}