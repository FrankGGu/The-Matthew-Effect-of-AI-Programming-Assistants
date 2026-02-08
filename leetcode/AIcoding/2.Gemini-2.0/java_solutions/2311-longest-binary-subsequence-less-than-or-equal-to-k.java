class Solution {
    public int longestSubsequence(String s, int k) {
        int n = s.length();
        int count = 0;
        int value = 0;
        for (int i = n - 1, pow = 1; i >= 0; i--) {
            if (s.charAt(i) == '0') {
                count++;
            } else {
                if (pow <= k) {
                    value += pow;
                    if (value <= k) {
                        count++;
                    } else {
                        value -= pow;
                    }
                }
                pow *= 2;
            }
        }
        return count;
    }
}