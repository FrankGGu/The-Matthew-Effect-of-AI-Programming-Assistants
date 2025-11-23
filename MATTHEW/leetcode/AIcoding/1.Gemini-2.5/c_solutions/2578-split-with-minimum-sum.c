#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumSum(int num) {
    int digits[4];
    digits[0] = num % 10;
    num /= 10;
    digits[1] = num % 10;
    num /= 10;
    digits[2] = num % 10;
    num /= 10;
    digits[3] = num % 10;

    qsort(digits, 4, sizeof(int), compare);

    int new1 = digits[0] * 10 + digits[2];
    int new2 = digits[1] * 10 + digits[3];

    return new1 + new2;
}