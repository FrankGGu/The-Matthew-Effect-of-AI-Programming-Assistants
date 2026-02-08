#include <stdlib.h>

int* getBeauty(int* nums, int numsSize, int k, int x, int* returnSize) {
    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    if (result == NULL) {
        return NULL;
    }

    int freq[101] = {0};

    for (int i = 0; i < k; i++) {
        freq[nums[i] + 50]++;
    }

    int current_count = 0;
    for (int j = 0; j <= 100; j++) {
        current_count += freq[j];
        if (current_count >= x) {
            int val = j - 50;
            result[0] = (val < 0) ? val : 0;
            break;
        }
    }

    for (int i = 1; i <= numsSize - k; i++) {
        freq[nums[i - 1] + 50]--;
        freq[nums[i + k - 1] + 50]++;

        current_count = 0;
        for (int j = 0; j <= 100; j++) {
            current_count += freq[j];
            if (current_count >= x) {
                int val = j - 50;
                result[i] = (val < 0) ? val : 0;
                break;
            }
        }
    }

    return result;
}