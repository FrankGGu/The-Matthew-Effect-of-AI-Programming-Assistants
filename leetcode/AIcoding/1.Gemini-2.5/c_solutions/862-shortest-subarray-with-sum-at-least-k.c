#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MAX

#ifndef MIN
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#endif

int shortestSubarray(int* nums, int numsSize, int k) {
    long long K_val = (long long)k; // Cast K to long long for comparison

    // Prefix sums array
    // P[i] stores sum of nums[0]...nums[i-1]
    // P has size numsSize + 1
    long long* P = (long long*)malloc(sizeof(long long) * (numsSize + 1));
    P[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        P[i+1] = P[i] + nums[i];
    }

    // Deque to store indices
    // `deque_indices` stores indices `j` such that P[j] is increasing
    int* deque_indices = (int*)malloc(sizeof(int) * (numsSize + 1));
    int head = 0; // Front of the deque (index of the first element)
    int tail = 0; // Back of the deque (index where the next element will be inserted)

    int min_len = numsSize + 1; // Initialize with a value larger than any possible length

    // Iterate through prefix sums P[k_idx] for k_idx from 0 to numsSize
    for (int k_idx = 0; k_idx <= numsSize; k_idx++) {
        // Condition 1: P[k_idx] - P[j] >= K_val
        // Pop from front while the condition holds and update min_len
        // These j values are no longer useful as they are too far back
        // and we've found the shortest subarray ending at k_idx with them.
        while (head < tail && P[k_idx] - P[deque_indices[head]] >= K_val) {
            min_len = MIN(min_len, k_idx - deque_indices[head]);
            head++;
        }

        // Condition 2: P[k_idx] <= P[deque_indices[tail-1]]
        // Pop from back while the current prefix sum P[k_idx] is less than or equal to
        // the prefix sum at the back of the deque.
        // This maintains the monotonic increasing property of P values in the deque.
        // If P[k_idx] is smaller, it's a better candidate for future subarrays
        // because it allows for a larger P[m] - P[k_idx] and a shorter length m - k_idx.
        while (head < tail && P[k_idx] <= P[deque_indices[tail-1]]) {
            tail--;
        }

        // Push current index k_idx to the back of the deque
        deque_indices[tail] = k_idx;
        tail++;
    }

    // Free allocated memory
    free(P);
    free(deque_indices);

    // If min_len is still numsSize + 1, no such subarray was found
    if (min_len == numsSize + 1) {
        return -1;
    } else {
        return min_len;
    }
}