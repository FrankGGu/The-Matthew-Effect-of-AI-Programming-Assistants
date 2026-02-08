#include <stdio.h>
#include <stdlib.h>

int largestInteger(int num) {
    int even[10], odd[10];
    int evenCount = 0, oddCount = 0;

    while (num > 0) {
        int digit = num % 10;
        if (digit % 2 == 0) {
            even[evenCount++] = digit;
        } else {
            odd[oddCount++] = digit;
        }
        num /= 10;
    }

    qsort(even, evenCount, sizeof(int), cmp);
    qsort(odd, oddCount, sizeof(int), cmp);

    int result = 0;
    int factor = 1;
    for (int i = 0; i < evenCount + oddCount; i++) {
        if (i < evenCount && (oddCount == 0 || (even[i] > odd[0] && even[i] > even[0]))) {
            result += even[--evenCount] * factor;
        } else {
            result += odd[--oddCount] * factor;
        }
        factor *= 10;
    }

    return result;
}

int cmp(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}