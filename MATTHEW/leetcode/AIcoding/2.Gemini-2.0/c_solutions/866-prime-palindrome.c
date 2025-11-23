#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPalindrome(int n) {
    int num = n;
    int rev = 0;
    while (num > 0) {
        int digit = num % 10;
        rev = rev * 10 + digit;
        num /= 10;
    }
    return n == rev;
}

bool isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= sqrt(n); i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int primePalindrome(int n) {
    while (true) {
        if (isPalindrome(n) && isPrime(n)) {
            return n;
        }
        n++;
        if (10000000 < n && n < 100000000)
            n = 100000000;
    }
}