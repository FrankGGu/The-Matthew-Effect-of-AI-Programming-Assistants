class Solution {
    public int atMostN_givenDigitSet(String[] digits, int n) {
        String S = String.valueOf(n);
        int K = S.length();
        int D = digits.length;

        int[] digits_int = new int[D];
        for (int i = 0; i < D; i++) {
            digits_int[i] = Integer.parseInt(digits[i]);
        }

        int ans = 0;

        for (int i = 1; i < K; i++) {
            ans += (int) Math.pow(D, i);
        }

        boolean canFormN = true;
        for (int i = 0; i < K; i++) {
            int s_digit = S.charAt(i) - '0';
            boolean currentDigitMatched = false;

            for (int d_val : digits_int) {
                if (d_val < s_digit) {
                    ans += (int) Math.pow(D, K - 1 - i);
                } else if (d_val == s_digit) {
                    currentDigitMatched = true;
                } else {
                    break;
                }
            }

            if (!currentDigitMatched) {
                canFormN = false;
                break;
            }
        }

        if (canFormN) {
            ans += 1;
        }

        return ans;
    }
}