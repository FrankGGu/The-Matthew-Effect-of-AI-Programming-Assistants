#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return (*(char*)a - *(char*)b);
}

int splitNum(int num) {
    char digits[10];
    int len = 0;
    while (num > 0) {
        digits[len++] = num % 10 + '0';
        num /= 10;
    }
    qsort(digits, len, sizeof(char), cmp);

    int num1 = 0, num2 = 0;
    for (int i = 0; i < len; i++) {
        if (i % 2 == 0) {
            num1 = num1 * 10 + (digits[i] - '0');
        } else {
            num2 = num2 * 10 + (digits[i] - '0');
        }
    }

    return num1 + num2;
}