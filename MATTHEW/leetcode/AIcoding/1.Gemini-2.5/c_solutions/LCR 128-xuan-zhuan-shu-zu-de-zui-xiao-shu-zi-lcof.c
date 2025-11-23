#include <stdlib.h> // For malloc, qsort
#include <string.h> // Not strictly needed for this solution, but often useful

typedef struct {
    int val;
    int freq;
} FreqPair;

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int compareFreqPairs(const void *a, const void *b) {
    FreqPair *pairA = (FreqPair *)a;
    FreqPair *pairB = (FreqPair *)b;

    if (pairA->freq != pairB->freq) {
        return pairB->freq - pairA->freq; // Descending frequency
    }
    return pairA->val - pairB->val; // Ascending value for tie-breaking
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    if (numsSize == 0 || k == 0) {
        *returnSize = 0;
        return NULL;
    }

    // Step 1: Sort the input array to group identical elements together.
    // This allows easy frequency counting in a single pass.
    qsort(nums, numsSize, sizeof(int), compareInts);

    // Step 2: Count frequencies and store them in an array of FreqPair structs.
    // In the worst case, all elements are unique, so we need space for numsSize pairs.
    FreqPair* freqPairs = (FreqPair*)malloc(sizeof(FreqPair) * numsSize);
    if (freqPairs == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int uniqueCount = 0;
    int currentVal = nums[0];
    int currentFreq = 0;

    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] == currentVal) {
            currentFreq++;
        } else {
            // Store the frequency of the previous value
            freqPairs[uniqueCount].val = currentVal;
            freqPairs[uniqueCount].freq = currentFreq;
            uniqueCount++;

            // Reset for the new value
            currentVal = nums[i];
            currentFreq = 1;
        }
    }
    // Store the frequency of the last value processed
    freqPairs[uniqueCount].val = currentVal;
    freqPairs[uniqueCount].freq = currentFreq;
    uniqueCount++;

    // Step 3: Sort the FreqPair array by frequency in descending order.
    qsort(freqPairs, uniqueCount, sizeof(FreqPair), compareFreqPairs);

    // Step 4: Extract the top k frequent elements.
    // Ensure we don't try to return more elements than there are unique elements.
    int actualReturnCount = (k < uniqueCount) ? k : uniqueCount;
    int* result = (int*)malloc(sizeof(int) * actualReturnCount);
    if (result == NULL) {
        free(freqPairs); // Clean up allocated memory
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < actualReturnCount; ++i) {
        result[i] = freqPairs[i].val;
    }

    *returnSize = actualReturnCount;
    free(freqPairs); // Free the temporary array used for frequency counting

    return result;
}