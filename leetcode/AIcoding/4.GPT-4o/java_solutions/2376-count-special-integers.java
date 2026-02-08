class Solution {
    public int countSpecialNumbers(int n) {
        String s = String.valueOf(n);
        int len = s.length(), ans = 0;

        for (int i = 1; i < len; i++) {
            ans += 9 * permutation(9, i - 1);
        }

        boolean[] used = new boolean[10];
        for (int i = 0; i < len; i++) {
            for (int j = (i == 0 ? 1 : 0); j < s.charAt(i) - '0'; j++) {
                if (!used[j]) {
                    ans += permutation(9 - i, len - i - 1);
                }
            }
            if (used[s.charAt(i) - '0']) break;
            used[s.charAt(i) - '0'] = true;
        }

        return ans + 1;
    }

    private int permutation(int n, int k) {
        int res = 1;
        for (int i = 0; i < k; i++) {
            res *= n - i;
        }
        return res;
    }
}