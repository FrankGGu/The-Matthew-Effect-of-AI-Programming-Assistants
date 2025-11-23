#include <stdlib.h> // For malloc, calloc, qsort

typedef struct {
    int val;
    int original_idx;
} Element;

int compareElements(const void *a, const void *b) {
    Element *elemA = (Element *)a;
    Element *elemB = (Element *)b;

    if (elemA->val != elemB->val) {
        return elemA->val - elemB->val;
    }
    return elemA->original_idx - elemB->original_idx;
}

long long* sumOfDistances(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    long long* ans = (long long*)calloc(numsSize, sizeof(long long));
    if (ans == NULL) {
        return NULL;
    }

    Element* elements = (Element*)malloc(numsSize * sizeof(Element));
    if (elements == NULL) {
        free(ans);
        return NULL;
    }

    for (int i = 0; i < numsSize; i++) {
        elements[i].val = nums[i];
        elements[i].original_idx = i;
    }

    qsort(elements, numsSize, sizeof(Element), compareElements);

    int i = 0;
    while (i < numsSize) {
        int j = i;
        while (j < numsSize && elements[j].val == elements[i].val) {
            j++;
        }
        int groupSize = j - i;

        long long* prefix_sum_indices = (long long*)calloc(groupSize + 1, sizeof(long long));
        if (prefix_sum_indices == NULL) {
            free(elements);
            free(ans);
            return NULL;
        }

        for (int k = 0; k < groupSize; k++) {
            prefix_sum_indices[k+1] = prefix_sum_indices[k] + elements[i+k].original_idx;
        }

        for (int k = 0; k < groupSize; k++) {
            long long current_idx = elements[i+k].original_idx;

            long long left_sum_dist = (long long)k * current_idx - prefix_sum_indices[k];

            long long right_sum_indices = prefix_sum_indices[groupSize] - prefix_sum_indices[k+1];
            long long right_sum_dist = right_sum_indices - (long long)(groupSize - 1 - k) * current_idx;

            ans[current_idx] = left_sum_dist + right_sum_dist;
        }

        free(prefix_sum_indices);

        i = j;
    }

    free(elements);

    return ans;
}