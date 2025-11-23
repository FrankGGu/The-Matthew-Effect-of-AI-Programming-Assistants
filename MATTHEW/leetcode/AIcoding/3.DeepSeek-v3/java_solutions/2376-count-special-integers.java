class Solution {
    public int countSpecialNumbers(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int[] digits = new int[len];
        for (int i = 0; i < len; i++) {
            digits[i] = s.charAt(i) - '0';
        }

        int res = 0;
        for (int l = 1; l < len; l++) {
            res += 9 * permutation(9, l - 1);
        }

        boolean[] used = new boolean[10];
        res += backtrack(digits, 0, used);
        return res;
    }

    private int backtrack(int[] digits, int pos, boolean[] used) {
        if (pos == digits.length) {
            return 1;
        }

        int res = 0;
        for (int d = 0; d < digits[pos]; d++) {
            if (pos == 0 && d == 0) continue;
            if (!used[d]) {
                res += permutation(10 - (pos + 1), digits.length - pos - 1);
            }
        }

        if (!used[digits[pos]]) {
            used[digits[pos]] = true;
            res += backtrack(digits, pos + 1, used);
        }

        return res;
    }

    private int permutation(int n, int k) {
        int res = 1;
        for (int i = 0; i < k; i++) {
            res *= (n - i);
        }
        return res;
    }
}