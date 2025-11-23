class Solution {
    public boolean canTransform(int[] arr) {
        int n = arr.length;
        long sum = 0;
        for (int num : arr) {
            sum += num;
        }
        if (sum % n != 0) return false;
        long target = sum / n;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + arr[i] - target;
        }
        long min = Long.MAX_VALUE, max = Long.MIN_VALUE;
        for (long val : prefix) {
            min = Math.min(min, val);
            max = Math.max(max, val);
        }
        return max - min <= 1;
    }
}