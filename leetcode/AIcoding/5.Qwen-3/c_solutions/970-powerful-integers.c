#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int* powerfulIntegers(int x, int y, int maxSum, int* returnSize) {
    int* result = NULL;
    int count = 0;

    for (int i = 0; pow(x, i) <= maxSum; i++) {
        for (int j = 0; pow(y, j) <= maxSum; j++) {
            int val = pow(x, i) + pow(y, j);
            if (val <= maxSum) {
                count++;
            }
        }
    }

    result = (int*)malloc(count * sizeof(int));
    int index = 0;

    for (int i = 0; pow(x, i) <= maxSum; i++) {
        for (int j = 0; pow(y, j) <= maxSum; j++) {
            int val = pow(x, i) + pow(y, j);
            if (val <= maxSum) {
                result[index++] = val;
            }
        }
    }

    *returnSize = count;
    return result;
}