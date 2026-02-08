/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* answerQueries(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize) {
    *returnSize = queriesSize;
    int* answer = (int*)malloc(queriesSize * sizeof(int));

    // Sort the nums array
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (nums[j] > nums[j + 1]) {
                int temp = nums[j];
                nums[j] = nums[j + 1];
                nums[j + 1] = temp;
            }
        }
    }

    // Calculate prefix sums
    int* prefix = (int*)malloc(numsSize * sizeof(int));
    prefix[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    // Answer each query using binary search
    for (int i = 0; i < queriesSize; i++) {
        int left = 0, right = numsSize - 1;
        int maxLen = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (prefix[mid] <= queries[i]) {
                maxLen = mid + 1;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        answer[i] = maxLen;
    }

    free(prefix);
    return answer;
}