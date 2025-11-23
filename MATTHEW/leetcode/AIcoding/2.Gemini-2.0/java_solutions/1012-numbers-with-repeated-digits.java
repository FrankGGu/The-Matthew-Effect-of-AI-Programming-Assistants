public class NumbersWithRepeatedDigits {
    public int numDupDigitsAtMostN(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int ans = 0;

        for (int i = 1; i < len; i++) {
            ans += 9 * A(9, i - 1);
        }

        boolean[] seen = new boolean[10];
        for (int i = 0; i < len; i++) {
            int d = s.charAt(i) - '0';
            for (int j = (i == 0 ? 1 : 0); j < d; j++) {
                if (!seen[j]) {
                    ans += A(9 - i, len - i - 1);
                }
            }
            if (seen[d]) {
                break;
            }
            seen[d] = true;
            if (i == len - 1) {
                ans++;
            }
        }

        return n - ans;
    }

    private int A(int m, int n) {
        int ans = 1;
        for (int i = 0; i < n; i++) {
            ans *= (m - i);
        }
        return ans;
    }
}