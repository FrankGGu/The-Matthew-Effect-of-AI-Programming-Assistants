#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool is_palindrome_rearrangeable(int mask) {
    return (mask == 0) || ((mask & (mask - 1)) == 0);
}

bool* canMakePalindromeQueries(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = strlen(s);

    int* prefix_xor_mask = (int*)malloc((n + 1) * sizeof(int));
    prefix_xor_mask[0] = 0;

    for (int i = 0; i < n; ++i) {
        prefix_xor_mask[i + 1] = prefix_xor_mask[i] ^ (1 << (s[i] - 'a'));
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int q_idx = 0; q_idx < queriesSize; ++q_idx) {
        int left1 = queries[q_idx][0];
        int right1 = queries[q_idx][1];
        int left2 = queries[q_idx][2];
        int right2 = queries[q_idx][3];

        int mask1 = prefix_xor_mask[right1 + 1] ^ prefix_xor_mask[left1];
        int mask2 = prefix_xor_mask[right2 + 1] ^ prefix_xor_mask[left2];

        if (!is_palindrome_rearrangeable(mask1)) {
            result[q_idx] = false;
            continue;
        }

        if (!is_palindrome_rearrangeable(mask2)) {
            result[q_idx] = false;
            continue;
        }

        int combined_mask = mask1 ^ mask2;
        if (!is_palindrome_rearrangeable(combined_mask)) {
            result[q_idx] = false;
            continue;
        }

        result[q_idx] = true;
    }

    free(prefix_xor_mask);
    return result;
}