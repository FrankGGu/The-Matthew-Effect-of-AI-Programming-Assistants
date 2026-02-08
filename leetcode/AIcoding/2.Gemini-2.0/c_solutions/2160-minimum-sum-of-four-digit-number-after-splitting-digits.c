#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumSum(int num) {
    int digits[4];
    for (int i = 0; i < 4; i++) {
        digits[i] = num % 10;
        num /= 10;
    }
    qsort(digits, 4, sizeof(int), compare);
    return (digits[0] + digits[1]) * 10 + digits[2] + digits[3];
}