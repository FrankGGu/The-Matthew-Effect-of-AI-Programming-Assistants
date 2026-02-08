int largestPalindrome(int n) {
    if (n == 1) return 9;
    long upper = pow(10, n) - 1;
    long lower = pow(10, n - 1);
    long maxPalindrome = 0;

    for (long i = upper; i >= lower; i--) {
        long palindrome = i;
        long temp = i;

        while (temp > 0) {
            palindrome = palindrome * 10 + temp % 10;
            temp /= 10;
        }

        for (long j = upper; j * j >= palindrome; j--) {
            if (palindrome % j == 0 && palindrome / j <= upper) {
                maxPalindrome = fmax(maxPalindrome, palindrome);
                break;
            }
        }
    }
    return maxPalindrome % 1337;
}