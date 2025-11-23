#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long smallestNumber(int k) {
    if (k == 1) {
        return 1;
    }

    int digits[20];
    int count = 0;

    for (int d = 9; d >= 2; --d) {
        while (k % d == 0) {
            digits[count++] = d;
            k /= d;
        }
    }

    if (k > 1) {
        return -1;
    }

    qsort(digits, count, sizeof(int), compare);

    long long result = 0;
    for (int i = 0; i < count; ++i) {
        result = result * 10 + digits[i];
    }

    return result;
}