#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isStrictlyPalindromic(int n) {
    for (int base = 2; base <= n - 1; base++) {
        char buffer[32];
        int i = 0;
        int num = n;
        while (num > 0) {
            buffer[i++] = num % base + '0';
            num /= base;
        }
        buffer[i] = '\0';
        int left = 0;
        int right = strlen(buffer) - 1;
        while (left < right) {
            if (buffer[left] != buffer[right]) {
                return false;
            }
            left++;
            right--;
        }
    }
    return true;
}