#include <stdlib.h> // Required for malloc/calloc in some contexts, though not strictly for this problem's logic.
#include <string.h> // Required for memset in some contexts, though not strictly for this problem's logic.

int subarraysDivByK(int* nums, int numsSize, int k) {
    int* counts = (int*)calloc(k, sizeof(int));
    if (counts == NULL) {
        // Handle allocation failure, though LeetCode usually guarantees success for small K
        return 0; 
    }

    counts[0] = 1; // For the case where prefix sum itself is divisible by K (empty prefix sum 0)
    int currentSum = 0;
    int ans = 0;

    for (int i = 0; i < numsSize; i++) {
        currentSum += nums[i];
        int remainder = currentSum % k;
        // Adjust negative remainders to be in [0, k-1]
        if (remainder < 0) {
            remainder += k;
        }

        ans += counts[remainder];
        counts[remainder]++;
    }

    free(counts);
    return ans;
}