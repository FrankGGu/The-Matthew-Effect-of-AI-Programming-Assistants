#include <stdlib.h>
#include <string.h>

int* plusOne(int* digits, int digitsSize, int* returnSize) {
    for (int i = digitsSize - 1; i >= 0; i--) {
        if (digits[i] < 9) {
            digits[i]++;
            *returnSize = digitsSize;
            return digits;
        } else {
            digits[i] = 0;
        }
    }

    // If we reach here, all digits were 9 (e.g., [9,9,9])
    // We need a new array with an additional leading 1
    int* newDigits = (int*)malloc(sizeof(int) * (digitsSize + 1));
    if (newDigits == NULL) {
        // Handle allocation failure if necessary, though LeetCode usually assumes success
        *returnSize = 0;
        return NULL;
    }

    newDigits[0] = 1;
    for (int i = 1; i <= digitsSize; i++) {
        newDigits[i] = 0;
    }

    *returnSize = digitsSize + 1;
    return newDigits;
}