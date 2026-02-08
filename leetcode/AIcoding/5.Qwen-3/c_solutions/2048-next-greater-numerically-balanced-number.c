#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nextNumericallyBalancedNumber(int n) {
    int* count = (int*)calloc(10, sizeof(int));
    int len = 0;
    while (n > 0) {
        count[n % 10]++;
        n /= 10;
        len++;
    }

    for (int i = 0; i < 10; i++) {
        if (count[i] > 0) {
            if (count[i] != 1) return -1;
        }
    }

    if (len == 10) return -1;

    int target_len = len + 1;
    int start = 1;
    for (int i = 0; i < 10; i++) {
        if (count[i] == 0) {
            start = i;
            break;
        }
    }

    int* digits = (int*)malloc(target_len * sizeof(int));
    digits[0] = start;
    for (int i = 1; i < target_len; i++) {
        for (int j = 0; j < 10; j++) {
            if (count[j] == 0 && j != start) {
                digits[i] = j;
                break;
            }
        }
    }

    int result = 0;
    for (int i = 0; i < target_len; i++) {
        result = result * 10 + digits[i];
    }

    free(count);
    free(digits);
    return result;
}