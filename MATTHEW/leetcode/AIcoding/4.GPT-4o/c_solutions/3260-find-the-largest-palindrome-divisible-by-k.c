int largestPalindrome(int n, int k) {
    if (n == 1) return 9;
    long upper = pow(10, n) - 1;
    long lower = pow(10, n - 1);

    for (long i = upper; i >= lower; i--) {
        long palindrome = i;
        long rev = 0;
        long temp = i;
        while (temp) {
            rev = rev * 10 + temp % 10;
            temp /= 10;
        }
        palindrome = palindrome * pow(10, n) + rev;

        for (long j = upper / k; j * k >= lower; j--) {
            if (palindrome % (j * k) == 0) {
                return palindrome % 1337;
            }
        }
    }
    return 0;
}