#include <stdio.h>
#include <stdlib.h>

int* addToArrayForm(int* num, int numSize, int k, int* returnSize) {
    int carry = 0;
    int i = numSize - 1;

    while (k > 0 || carry > 0) {
        int digit = k % 10;
        k /= 10;

        if (i >= 0) {
            digit += num[i];
            i--;
        }

        digit += carry;
        carry = digit / 10;
        digit %= 10;

        num = (int*)realloc(num, (numSize + 1) * sizeof(int));
        for (int j = numSize; j > 0; j--) {
            num[j] = num[j - 1];
        }
        num[0] = digit;
        numSize++;
    }

    *returnSize = numSize;
    return num;
}