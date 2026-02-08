#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isStrictlyPalindromic(int n) {
    if (n < 4) return false;
    for (int base = 2; base <= n - 2; base++) {
        int temp = n;
        int digits[100];
        int count = 0;
        while (temp > 0) {
            digits[count++] = temp % base;
            temp /= base;
        }
        bool isPalindrome = true;
        for (int i = 0; i < count / 2; i++) {
            if (digits[i] != digits[count - 1 - i]) {
                isPalindrome = false;
                break;
            }
        }
        if (!isPalindrome) return false;
    }
    return true;
}