#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumSwap(int num) {
    char digits[16];
    sprintf(digits, "%d", num);
    int len = strlen(digits);
    int last[10] = {0};

    for (int i = 0; i < len; i++) {
        last[digits[i] - '0'] = i;
    }

    for (int i = 0; i < len; i++) {
        int d = digits[i] - '0';
        for (int j = 9; j > d; j--) {
            if (last[j] > i) {
                char temp = digits[i];
                digits[i] = digits[last[j]];
                digits[last[j]] = temp;
                return atoi(digits);
            }
        }
    }

    return num;
}