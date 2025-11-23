#include <stdlib.h> // For malloc, realloc, free, qsort

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int calculateSums(struct TreeNode* node, int** sums_ptr, int* sums_size_ptr, int* sums_capacity_ptr) {
    if (!node) {
        return 0;
    }

    int leftSum = calculateSums(node->left, sums_ptr, sums_size_ptr, sums_capacity_ptr);
    int rightSum = calculateSums(node->right, sums_ptr, sums_size_ptr, sums_capacity_ptr);

    int currentSum = node->val + leftSum + rightSum;

    // Add currentSum to the dynamically allocated sums array
    if (*sums_size_ptr == *sums_capacity_ptr) {
        *sums_capacity_ptr = (*sums_capacity_ptr == 0) ? 1 : (*sums_capacity_ptr * 2);
        *sums_ptr = (int*)realloc(*sums_ptr, *sums_capacity_ptr * sizeof(int));
        if (!*sums_ptr) {
            // Handle realloc failure, though LeetCode environments typically guarantee success
            exit(EXIT_FAILURE); 
        }
    }
    (*sums_ptr)[(*sums_size_ptr)++] = currentSum;

    return currentSum;
}

int* findFrequentTreeSum(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    if (!root) {
        return NULL;
    }

    int* sums = NULL;
    int sumsSize = 0;
    int sumsCapacity = 0;

    // Populate the sums array with all subtree sums
    calculateSums(root, &sums, &sumsSize, &sumsCapacity);

    if (sumsSize == 0) { // Should not happen if root is not NULL
        return NULL;
    }

    // Sort the sums array to easily count frequencies
    qsort(sums, sumsSize, sizeof(int), compareInts);

    int* result = NULL;
    int resultSize = 0;
    int resultCapacity = 0;
    int maxFreq = 0;

    int currentSum = sums[0];
    int currentFreq = 0;

    // Iterate through the sorted sums to find most frequent sums
    for (int i = 0; i < sumsSize; ++i) {
        if (sums[i] == currentSum) {
            currentFreq++;
        } else {
            // Process the previous sum's frequency
            if (currentFreq > maxFreq) {
                maxFreq = currentFreq;
                resultSize = 0; // Reset result for a new max frequency
                // Reallocate result array if needed, or initialize
                if (resultCapacity == 0) {
                    resultCapacity = 1;
                    result = (int*)malloc(resultCapacity * sizeof(int));
                } else {
                    result = (int*)realloc(result, resultCapacity * sizeof(int));
                }
                if (!result) exit(EXIT_FAILURE);
                result[resultSize++] = currentSum;
            } else if (currentFreq == maxFreq) {
                // Add to result if it has the same max frequency
                if (resultSize == resultCapacity) {
                    resultCapacity *= 2;
                    result = (int*)realloc(result, resultCapacity * sizeof(int));
                    if (!result) exit(EXIT_FAILURE);
                }
                result[resultSize++] = currentSum;
            }

            // Start counting for the new sum
            currentSum = sums[i];
            currentFreq = 1;
        }
    }

    // Process the last group of sums after the loop
    if (currentFreq > maxFreq) {
        maxFreq = currentFreq;
        resultSize = 0;
        if (resultCapacity == 0) {
            resultCapacity = 1;
            result = (int*)malloc(resultCapacity * sizeof(int));
        } else {
            result = (int*)realloc(result, resultCapacity * sizeof(int));
        }
        if (!result) exit(EXIT_FAILURE);
        result[resultSize++] = currentSum;
    } else if (currentFreq == maxFreq) {
        if (resultSize == resultCapacity) {
            resultCapacity *= 2;
            result = (int*)realloc(result, resultCapacity * sizeof(int));
            if (!result) exit(EXIT_FAILURE);
        }
        result[resultSize++] = currentSum;
    }

    free(sums); // Free the temporary sums array

    *returnSize = resultSize;
    return result;
}