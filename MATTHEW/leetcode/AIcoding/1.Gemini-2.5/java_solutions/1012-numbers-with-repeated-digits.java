import java.util.HashSet;
import java.util.Set;

class Solution {
    private int permutations(int n, int k) {
        if (k == 0) {
            return 1;
        }
        int res = 1;
        for (int i = 0; i < k; i++) {
            res *= (n - i);
        }
        return res;
    }

    public int numDupDigitsAtMostN(int n) {
        String s = String.valueOf(n);
        int L = s.length();

        int countNoRepeatedDigits = 0;

        for (int k = 1; k < L; k++) {
            countNoRepeatedDigits += 9 * permutations(9, k - 1);
        }

        Set<Integer> seen = new HashSet<>();
        for (int i = 0; i < L; i++) {
            int digit_at_N = s.charAt(i) - '0';

            for (int d = (i == 0 ? 1 : 0); d < digit_at_N; d++) {
                if (!seen.contains(d)) {
                    countNoRepeatedDigits += permutations(10 - seen.size() - 1, L - 1 - i);
                }
            }

            if (seen.contains(digit_at_N)) {
                break;
            }

            seen.add(digit_at_N);

            if (i == L - 1) {
                countNoRepeatedDigits++;
            }
        }

        return n - countNoRepeatedDigits;
    }
}