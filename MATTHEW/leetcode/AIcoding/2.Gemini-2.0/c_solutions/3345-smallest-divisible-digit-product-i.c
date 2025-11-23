#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int smallestNumber(int n) {
    if (n == 1) return 1;
    int digits[100], len = 0;
    for (int i = 9; i >= 2; i--) {
        while (n % i == 0) {
            digits[len++] = i;
            n /= i;
        }
    }
    if (n != 1) return -1;
    int res = 0;
    for (int i = len - 1; i >= 0; i--) {
        res = res * 10 + digits[i];
    }
    return res;
}