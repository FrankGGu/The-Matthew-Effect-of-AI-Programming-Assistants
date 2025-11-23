#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* distinctSquares(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int count = 0;
    int* squares = (int*)calloc(100000, sizeof(int)); // Assuming max value is 1e5

    for (int i = 0; i < numsSize; i++) {
        int square = nums[i] * nums[i];
        if (squares[square] == 0) {
            result[count++] = square;
            squares[square] = 1;
        }
    }

    free(squares);
    *returnSize = count;
    return result;
}