class Solution {
    public int monotoneIncreasingDigits(int n) {
        char[] s = String.valueOf(n).toCharArray();
        int k = s.length;
        for (int i = s.length - 1; i > 0; --i) {
            if (s[i] < s[i - 1]) {
                s[i - 1]--;
                k = i;
            }
        }
        for (int i = k; i < s.length; ++i) {
            s[i] = '9';
        }
        return Integer.parseInt(new String(s));
    }
}