class Solution {
    public int minimumTime(int[] passages) {
        int n = passages.length;
        long[] time = new long[n];
        time[0] = 0;
        for (int i = 1; i < n; i++) {
            time[i] = Math.max(time[i - 1] + 1, passages[i - 1]);
        }
        return (int) time[n - 1];
    }
}