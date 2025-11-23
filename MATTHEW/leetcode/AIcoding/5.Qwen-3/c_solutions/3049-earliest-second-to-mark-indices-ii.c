#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int earliestSecondToMarkIndices(int* nums, int numsSize, int* m, int mSize) {
    int n = numsSize;
    int k = mSize;
    int* indices = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        indices[i] = m[i];
    }
    qsort(indices, k, sizeof(int), compare);

    int* freq = (int*)calloc(n, sizeof(int));
    int count = 0;
    int result = 0;

    for (int i = 0; i < n; i++) {
        if (freq[nums[i]] == 0) {
            count++;
        }
        freq[nums[i]]++;
    }

    int left = 0;
    int right = 0;
    int currentCount = 0;
    int* window = (int*)calloc(n, sizeof(int));

    while (right < n) {
        int num = nums[right];
        window[num]++;
        if (window[num] == 1) {
            currentCount++;
        }

        while (currentCount == count) {
            if (left <= right) {
                int flag = 1;
                for (int i = 0; i < k; i++) {
                    if (window[indices[i]] == 0) {
                        flag = 0;
                        break;
                    }
                }
                if (flag) {
                    free(freq);
                    free(window);
                    free(indices);
                    return result;
                }
            }

            int leftNum = nums[left];
            window[leftNum]--;
            if (window[leftNum] == 0) {
                currentCount--;
            }
            left++;
        }
        result++;
    }

    free(freq);
    free(window);
    free(indices);
    return -1;
}