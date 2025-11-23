int largestPalindrome(int n) {
    if (n == 1) return 9;

    long max = (long)pow(10, n) - 1;
    long min = (long)pow(10, n - 1);

    for (long left = max; left >= min; left--) {
        long palindrome = left;
        for (long right = left; right > 0; right /= 10) {
            palindrome = palindrome * 10 + (right % 10);
        }

        for (long factor = max; factor * factor >= palindrome; factor--) {
            if (palindrome % factor == 0 && palindrome / factor >= min && palindrome / factor <= max) {
                return (int)(palindrome % 1337);
            }
        }
    }

    return -1;
}