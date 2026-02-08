#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDupDigitsAtMostN(int n, char* digits, int digitsSize) {
    char s[12];
    sprintf(s, "%d", n);
    int len = strlen(s);
    int res = 0;
    for (int i = 1; i < len; i++) {
        res += pow(digitsSize, i);
    }
    int used[10] = {0};
    for (int i = 0; i < len; i++) {
        int d = s[i] - '0';
        for (int j = 0; j < digitsSize; j++) {
            int digit = digits[j] - '0';
            if (digit < d) {
                res += pow(digitsSize, len - i - 1);
            } else if (digit == d) {
                used[digit] = 1;
                break;
            }
        }
        if (used[d]) break;
    }
    return res;
}