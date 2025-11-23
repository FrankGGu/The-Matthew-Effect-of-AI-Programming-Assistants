/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int* recoverArray(int* nums, int numsSize, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int* res = (int*)malloc(numsSize * sizeof(int) / 2);
    *returnSize = 0;

    for (int i = 1; i < numsSize; i++) {
        int k2 = nums[i] - nums[0];
        if (k2 == 0 || k2 % 2 != 0) continue;

        int k = k2 / 2;
        int* used = (int*)calloc(numsSize, sizeof(int));
        int left = 0, right = i;
        used[0] = used[i] = 1;

        int idx = 0;
        res[idx++] = nums[0] + k;

        for (int j = 1; j < numsSize; j++) {
            if (used[j]) continue;
            while (left < numsSize && (used[left] || nums[left] < nums[j] - 2 * k)) {
                left++;
            }
            if (left < numsSize && nums[left] == nums[j] - 2 * k) {
                used[left] = used[j] = 1;
                res[idx++] = nums[j] - k;
            } else {
                break;
            }
        }

        if (idx == numsSize / 2) {
            *returnSize = idx;
            free(used);
            return res;
        }

        free(used);
    }

    free(res);
    return NULL;
}