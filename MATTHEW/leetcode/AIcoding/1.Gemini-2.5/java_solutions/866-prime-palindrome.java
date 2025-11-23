class Solution {
    public int primePalindrome(int N) {
        // Handle small N values that result in 1-digit or 2-digit prime palindromes.
        // These are special because 11 is an even-digit palindrome, and 
        // the main loop only generates odd-digit palindromes.
        if (N <= 2) return 2;
        if (N <= 3) return 3;
        if (N <= 5) return 5;
        if (N <= 7) return 7;
        if (N <= 11) return 11; // Handles N=8, 9, 10, 11.

        // The problem guarantees the answer is less than 2 * 10^8.
        // All even-digit palindromes (except 11) are divisible by 11 and thus not prime.
        // So we only need to search for odd-digit palindromes.
        // We generate palindromes by constructing the first half `x` and mirroring it.
        // For an odd-length palindrome, if `x` is "abc", the palindrome is "abcba".
        // This means `x` forms the first half including the middle digit.
        // The loop for `x` should go up to a value such that the generated palindrome
        // is less than 2 * 10^8.
        // The largest palindrome less than 2 * 10^8 is 1999999991 (from x=19999).
        // The maximum answer for N=10^8 is 100030001 (from x=10003).
        // So, iterating `x` up to 20000 is a safe upper bound to cover all possible answers.
        for (int x = 1; x < 20000; x++) {
            String s = String.valueOf(x);
            String rev_s = new StringBuilder(s).reverse().toString();

            // Construct an odd-length palindrome
            // Example: x=123 -> s="123", rev_s="321". Palindrome = "123" + "21" = 12321.
            int p = Integer.parseInt(s + rev_s.substring(1));

            if (p >= N && isPrime(p)) {
                return p;
            }
        }
        return -1; // Should not be reached based on problem constraints.
    }

    private boolean isPrime(int n) {
        if (n < 2) return false;
        if (n == 2 || n == 3) return true;
        if (n % 2 == 0 || n % 3 == 0) return false;
        // Optimized trial division: check divisors of the form 6k +/- 1
        for (int i = 5; i * i <= n; i = i + 6) {
            if (n % i == 0 || n % (i + 2) == 0) {
                return false;
            }
        }
        return true;
    }
}