#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long reverse(long long n) {
    long long rev = 0;
    while (n > 0) {
        rev = rev * 10 + n % 10;
        n /= 10;
    }
    return rev;
}

long long buildPalindrome(long long n, bool odd) {
    long long res = n;
    if (odd) n /= 10;
    return res * pow(10, floor(log10(n) + 1)) + reverse(n);
}

bool isPalindrome(long long n) {
    long long original = n;
    long long reversed = 0;
    while (n > 0) {
        reversed = reversed * 10 + n % 10;
        n /= 10;
    }
    return original == reversed;
}

bool isSuperPalindrome(long long n) {
    if (!isPalindrome(n)) return false;
    long long root = sqrt(n);
    return (long long)pow(root, 2) == n && isPalindrome(root);
}

int superpalindromesInRange(char * left, char * right){
    long long L = atoll(left);
    long long R = atoll(right);
    int count = 0;

    for (long long i = 1; i < 100000; i++) {
        long long oddPalindrome = buildPalindrome(i, true);
        long long evenPalindrome = buildPalindrome(i, false);

        if (oddPalindrome >= L && oddPalindrome <= R && isSuperPalindrome(oddPalindrome)) {
            count++;
        }
        if (evenPalindrome >= L && evenPalindrome <= R && isSuperPalindrome(evenPalindrome)) {
            count++;
        }
    }
    return count;
}