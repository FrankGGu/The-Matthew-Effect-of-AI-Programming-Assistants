int isPalindrome(int n) {
    int reversed = 0, original = n;
    while (n > 0) {
        reversed = reversed * 10 + n % 10;
        n /= 10;
    }
    return original == reversed;
}

int isPrime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int primePalindrome(int n) {
    if (n <= 2) return 2;
    for (int i = 1; i <= 1000000; i++) {
        int palindrome = i;
        int multiplier = 1;
        while (palindrome > 0) {
            multiplier *= 10;
            palindrome /= 10;
        }
        palindrome = i;
        for (int j = multiplier / 10; j > 0; j /= 10) {
            palindrome = palindrome * 10 + (i / j) % 10;
        }
        if (palindrome >= n && isPrime(palindrome)) {
            return palindrome;
        }
    }
    return -1;
}