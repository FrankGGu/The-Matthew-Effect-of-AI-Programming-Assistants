#include <stdlib.h>
#include <stdbool.h>

bool* specialArray(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    bool* answer = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    int* next_same_parity_idx = (int*)malloc(numsSize * sizeof(int));

    if (numsSize > 0) {
        next_same_parity_idx[numsSize - 1] = numsSize; // Sentinel value
    }

    for (int i = numsSize - 2; i >= 0; --i) {
        if ((nums[i] % 2) == (nums[i+1] % 2)) {
            next_same_parity_idx[i] = i;
        } else {
            next_same_parity_idx[i] = next_same_parity_idx[i+1];
        }
    }

    for (int q_idx = 0; q_idx < queriesSize; ++q_idx) {
        int l = queries[q_idx][0];
        int r = queries[q_idx][1];

        if (l == r) {
            answer[q_idx] = true;
        } else {
            answer[q_idx] = (next_same_parity_idx[l] >= r);
        }
    }

    free(next_same_parity_idx);

    return answer;
}