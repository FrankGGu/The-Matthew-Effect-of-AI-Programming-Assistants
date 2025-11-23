class Solution {
    public int monotoneIncreasingDigits(int n) {
        char[] s = String.valueOf(n).toCharArray();
        int len = s.length;
        int mark = len;

        for (int i = len - 2; i >= 0; i--) {
            if (s[i] > s[i + 1]) {
                s[i]--;
                mark = i + 1;
            }
        }

        for (int i = mark; i < len; i++) {
            s[i] = '9';
        }

        return Integer.parseInt(new String(s));
    }
}