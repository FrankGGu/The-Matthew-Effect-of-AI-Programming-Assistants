#include <stdlib.h>

int* getMaximumXor(int* nums, int numsSize, int maximumBit, int* returnSize) {
    int* answer = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    int current_xor_sum = 0;
    int mask = (1 << maximumBit) - 1;

    for (int i = 0; i < numsSize; i++) {
        current_xor_sum ^= nums[i];
        // To maximize current_xor_sum XOR k, k should ideally be ~current_xor_sum.
        // Since k must be less than 2^maximumBit, we only care about the lower maximumBit bits.
        // So, k = (~current_xor_sum) & mask.
        answer[i] = (~current_xor_sum) & mask;
    }

    return answer;
}