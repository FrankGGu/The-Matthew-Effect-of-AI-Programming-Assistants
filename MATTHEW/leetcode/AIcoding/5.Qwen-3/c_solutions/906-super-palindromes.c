#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long reverse(long long n) {
    long long rev = 0;
    while (n > 0) {
        rev = rev * 10 + n % 10;
        n /= 10;
    }
    return rev;
}

int isPalindrome(long long n) {
    return n == reverse(n);
}

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long pow10(int n) {
    long long result = 1;
    for (int i = 0; i < n; i++) {
        result *= 10;
    }
    return result;
}

long long superPalindromes(long long L, long long R) {
    long long count = 0;
    long long max_limit = (long long)sqrt(R) + 1;

    for (long long i = 1; i <= max_limit; i++) {
        long long square = i * i;
        if (square >= L && square <= R && isPalindrome(square)) {
            count++;
        }
    }

    for (long long i = 1; i <= max_limit; i++) {
        long long s = i;
        for (int j = 0; j < 2; j++) {
            long long temp = s;
            for (int k = 0; k < 9; k++) {
                temp = temp * 10 + (i / pow10(k)) % 10;
            }
            long long square = temp * temp;
            if (square >= L && square <= R && isPalindrome(square)) {
                count++;
            }
            s = s * 10 + (i / pow10(0)) % 10;
        }
    }

    return count;
}