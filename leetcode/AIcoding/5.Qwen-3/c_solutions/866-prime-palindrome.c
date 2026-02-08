#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int is_prime(int n) {
    if (n < 2) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;
    int sqrt_n = (int)sqrt(n);
    for (int i = 3; i <= sqrt_n; i += 2) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int is_palindrome(int n) {
    int reversed = 0, original = n;
    while (n > 0) {
        reversed = reversed * 10 + n % 10;
        n /= 10;
    }
    return original == reversed;
}

int primePalindrome(int n) {
    if (n <= 2) return 2;
    if (n == 3) return 3;
    if (n == 5) return 5;
    if (n == 7) return 7;

    for (int i = 11; ; i += 2) {
        if (is_palindrome(i) && is_prime(i)) {
            return i;
        }
    }
}