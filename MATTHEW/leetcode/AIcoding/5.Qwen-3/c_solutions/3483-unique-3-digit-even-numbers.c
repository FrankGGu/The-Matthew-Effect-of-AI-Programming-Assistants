#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    bool used[3] = {false};
    int* result = (int*)malloc(1000 * sizeof(int));
    int count = 0;

    for (int i = 0; i < digitsSize; i++) {
        if (digits[i] == 0) continue;
        used[i] = true;
        for (int j = 0; j < digitsSize; j++) {
            if (i == j || used[j]) continue;
            used[j] = true;
            for (int k = 0; k < digitsSize; k++) {
                if (i == k || j == k || used[k]) continue;
                if (digits[k] % 2 == 0) {
                    int num = digits[i] * 100 + digits[j] * 10 + digits[k];
                    result[count++] = num;
                }
            }
            used[j] = false;
        }
        used[i] = false;
    }

    *returnSize = count;
    return result;
}