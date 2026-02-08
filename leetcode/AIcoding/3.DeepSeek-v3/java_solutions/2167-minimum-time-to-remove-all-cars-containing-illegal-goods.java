class Solution {
    public int minimumTime(String s) {
        int n = s.length();
        int[] left = new int[n + 1];
        for (int i = 0; i < n; i++) {
            left[i + 1] = Math.min(left[i] + 2 * (s.charAt(i) - '0'), i + 1);
        }
        int[] right = new int[n + 1];
        for (int i = n - 1; i >= 0; i--) {
            right[i] = Math.min(right[i + 1] + 2 * (s.charAt(i) - '0'), n - i);
        }
        int res = Integer.MAX_VALUE;
        for (int i = 0; i <= n; i++) {
            res = Math.min(res, left[i] + right[i]);
        }
        return res;
    }
}