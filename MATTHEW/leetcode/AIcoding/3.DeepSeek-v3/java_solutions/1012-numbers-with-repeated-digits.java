class Solution {
    public int numDupDigitsAtMostN(int N) {
        return N - countNoRepeat(N);
    }

    private int countNoRepeat(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int total = 0;

        for (int i = 1; i < len; i++) {
            total += 9 * permutation(9, i - 1);
        }

        boolean[] used = new boolean[10];
        for (int i = 0; i < len; i++) {
            int digit = s.charAt(i) - '0';
            for (int j = (i == 0 ? 1 : 0); j < digit; j++) {
                if (!used[j]) {
                    total += permutation(9 - i, len - i - 1);
                }
            }
            if (used[digit]) break;
            used[digit] = true;
        }

        if (!hasRepeatedDigits(n)) {
            total++;
        }
        return total;
    }

    private boolean hasRepeatedDigits(int num) {
        boolean[] seen = new boolean[10];
        while (num > 0) {
            int d = num % 10;
            if (seen[d]) return true;
            seen[d] = true;
            num /= 10;
        }
        return false;
    }

    private int permutation(int n, int k) {
        if (k == 0) return 1;
        int res = 1;
        for (int i = 0; i < k; i++) {
            res *= (n - i);
        }
        return res;
    }
}