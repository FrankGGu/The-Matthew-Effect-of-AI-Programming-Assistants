class Solution {
    public int numDupDigitsAtMostN(int N) {
        String s = String.valueOf(N);
        int len = s.length();
        int res = 0;

        for (int i = 1; i < len; i++) {
            res += 9 * perm(9, i - 1);
        }

        boolean[] seen = new boolean[10];
        for (int i = 0; i < len; i++) {
            int cur = s.charAt(i) - '0';
            for (int j = 0; j < cur; j++) {
                if (!seen[j]) {
                    res += perm(9 - i, len - i - 1);
                }
            }
            if (seen[cur]) break;
            seen[cur] = true;
        }

        return N - res;
    }

    private int perm(int m, int n) {
        int res = 1;
        for (int i = 0; i < n; i++) {
            res *= m - i;
        }
        return res;
    }
}