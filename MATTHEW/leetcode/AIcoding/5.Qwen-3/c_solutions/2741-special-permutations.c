#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} Vector;

Vector* create_vector(int capacity) {
    Vector* vec = (Vector*)malloc(sizeof(Vector));
    vec->data = (int*)malloc(capacity * sizeof(int));
    vec->size = 0;
    return vec;
}

void free_vector(Vector* vec) {
    free(vec->data);
    free(vec);
}

void push_back(Vector* vec, int value) {
    vec->data[vec->size++] = value;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

long long specialPermutations(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int n = numsSize;
    long long dp[1 << n];
    for (int i = 0; i < (1 << n); i++) {
        dp[i] = 0;
    }

    for (int mask = 0; mask < (1 << n); mask++) {
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) count++;
        }

        if (count == 0) {
            dp[mask] = 0;
            continue;
        }

        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                int new_mask = mask ^ (1 << i);
                if (new_mask == 0) {
                    dp[mask] += 1;
                } else {
                    for (int j = 0; j < n; j++) {
                        if (new_mask & (1 << j)) {
                            if (nums[i] % nums[j] == 0 || nums[j] % nums[i] == 0) {
                                dp[mask] += dp[new_mask];
                            }
                        }
                    }
                }
            }
        }
    }

    return dp[(1 << n) - 1];
}