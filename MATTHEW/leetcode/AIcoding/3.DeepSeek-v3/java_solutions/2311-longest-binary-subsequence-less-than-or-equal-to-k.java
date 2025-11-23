class Solution {
    public int longestSubsequence(String s, int k) {
        int n = s.length();
        int res = 0;
        int sum = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == '0') {
                res++;
            } else {
                if (res < 30 && sum + (1 << res) <= k) {
                    sum += 1 << res;
                    res++;
                }
            }
        }
        return res;
    }
}