class Solution {
    public int superpalindromesInRange(String L, String R) {
        long L_long = Long.parseLong(L);
        long R_long = Long.parseLong(R);
        int count = 0;

        // Iterate through prefixes 'i' to build palindromic roots 'x'.
        // The maximum value for 'x' such that x*x <= 10^18 is x = 10^9.
        // We need to generate palindromes 'x' up to 10^9.
        //
        // If 'x' is an odd-length palindrome, it is formed from `s + s_rev.substring(1)`.
        // If `s` (which is `i`) has `k` digits, `x` has `2k-1` digits.
        // To get `x <= 10^9` (i.e., `x` has at most 9 digits), `2k-1 <= 9` => `2k <= 10` => `k <= 5`.
        // So `i` can have at most 5 digits. The largest 5-digit `i` is 99999.
        // For `i = 99999`, `x_odd = 999999999`. This is `<= 10^9`.
        //
        // If 'x' is an even-length palindrome, it is formed from `s + s_rev`.
        // If `s` (which is `i`) has `k` digits, `x` has `2k` digits.
        // To get `x <= 10^9` (i.e., `x` has at most 9 digits), `2k <= 9` => `k <= 4.5` => `k <= 4`.
        // So `i` can have at most 4 digits for even-length palindromes.
        // The largest 4-digit `i` is 9999. For `i = 9999`, `x_even = 99999999`. This is `<= 10^9`.
        // For `i = 10000`, `x_even = 1000000001`. This is `> 10^9`.
        //
        // Therefore, the loop for 'i' should go up to 99999 (i.e., `i < 100000`).
        // Inside the loop, we will check if generated 'x' values are within limits.

        for (long i = 1; i < 100000; i++) {
            String s = String.valueOf(i);
            String reversedS = new StringBuilder(s).reverse().toString();

            // --- Form and check odd length palindrome x1 ---
            long x1 = Long.parseLong(s + reversedS.substring(1));

            // If x1 itself is too large (i.e., its square would exceed 10^18),
            // we can stop. Since 'i' is increasing, subsequent x1 values will also be too large.
            // Also, x2 for this 'i' would be even larger.
            if (x1 > 1000000000L) { // 10^9 is sqrt(10^18), so if x1 > 10^9, x1^2 > 10^18.
                break; 
            }

            long sq1 = x1 * x1;
            if (sq1 > R_long) {
                // If sq1 exceeds R_long, then for increasing 'i', subsequent squares will also exceed R_long.
                break;
            }
            if (sq1 >= L_long && isPalindrome(sq1)) {
                count++;
            }

            // --- Form and check even length palindrome x2 ---
            // This part of the code might generate x2 values that are very large (e.g., 10^10)
            // which would cause overflow if we calculate x2*x2 without checking x2 first.
            // The check `x2 > 1000000000L` is crucial for preventing overflow and early skipping.

            long x2 = Long.parseLong(s + reversedS);

            // If x2 itself is too large (i.e., its square would exceed 10^18), skip it.
            // This check is important to prevent overflow when calculating x2*x2.
            if (x2 > 1000000000L) { // x2 > sqrt(10^18)
                continue; // Skip this x2, continue to next 'i'
            }

            long sq2 = x2 * x2;
            if (sq2 > R_long) {
                // If sq2 exceeds R_long, skip it.
                // We cannot break the loop for 'i' here, because x1 for the next 'i' might still be valid.
                continue;
            }
            if (sq2 >= L_long && isPalindrome(sq2)) {
                count++;
            }
        }
        return count;
    }

    private boolean isPalindrome(long n) {
        String s = String.valueOf(n);
        int len = s.length();
        for (int i = 0; i < len / 2; i++) {
            if (s.charAt(i) != s.charAt(len - 1 - i)) {
                return false;
            }
        }
        return true;
    }
}