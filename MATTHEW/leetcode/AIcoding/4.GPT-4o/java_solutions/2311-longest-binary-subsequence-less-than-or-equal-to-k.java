class Solution {
    public int longestSubsequence(String s, int k) {
        int n = s.length();
        int count = 0;
        long num = 0;

        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == '0' || (num | (1L << count)) <= k) {
                if (s.charAt(i) == '1') {
                    num |= (1L << count);
                }
                count++;
            }
        }
        return count;
    }
}