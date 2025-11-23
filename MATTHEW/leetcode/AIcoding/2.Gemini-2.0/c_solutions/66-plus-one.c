#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* plusOne(int* digits, int digitsSize, int* returnSize){
    int carry = 1;
    for (int i = digitsSize - 1; i >= 0; i--) {
        int sum = digits[i] + carry;
        digits[i] = sum % 10;
        carry = sum / 10;
    }

    if (carry > 0) {
        int* result = (int*)malloc(sizeof(int) * (digitsSize + 1));
        result[0] = carry;
        for (int i = 0; i < digitsSize; i++) {
            result[i + 1] = digits[i];
        }
        *returnSize = digitsSize + 1;
        return result;
    } else {
        *returnSize = digitsSize;
        return digits;
    }
}