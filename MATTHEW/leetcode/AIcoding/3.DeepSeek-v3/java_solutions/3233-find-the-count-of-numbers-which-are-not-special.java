class Solution {
    public int countSpecialNumbers(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int[] digits = new int[len];
        for (int i = 0; i < len; i++) {
            digits[i] = s.charAt(i) - '0';
        }

        int res = 0;
        for (int i = 1; i < len; i++) {
            res += 9 * permutation(9, i - 1);
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
        for (int i = 0; i < digits[pos]; i++) {
            if (i == 0 && pos == 0) continue;
            if (!used[i]) {
                res += permutation(9 - pos, digits.length - pos - 1);
            }
        }

        if (!used[digits[pos]]) {
            used[digits[pos]] = true;
            res += backtrack(digits, pos + 1, used);
            used[digits[pos]] = false;
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