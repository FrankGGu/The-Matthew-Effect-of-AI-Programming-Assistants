class Solution {
    public int uniqueLetterString(String s) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];
        int[] lastPos = new int[26];

        for (int i = 0; i < 26; i++) {
            lastPos[i] = -1;
        }

        for (int i = 0; i < n; i++) {
            int c = s.charAt(i) - 'A';
            left[i] = i - (lastPos[c] == -1 ? -1 : lastPos[c]);
            lastPos[c] = i;
        }

        for (int i = 0; i < 26; i++) {
            lastPos[i] = n;
        }

        for (int i = n - 1; i >= 0; i--) {
            int c = s.charAt(i) - 'A';
            right[i] = (lastPos[c] == n ? n : lastPos[c]) - i;
            lastPos[c] = i;
        }

        long ans = 0;
        for (int i = 0; i < n; i++) {
            ans += (long) left[i] * right[i];
        }

        return (int) (ans % 1000000007);
    }
}