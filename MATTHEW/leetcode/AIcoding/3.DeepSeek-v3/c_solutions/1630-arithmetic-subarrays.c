/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
bool check(int* arr, int size) {
    if (size <= 2) return true;

    int min_val = arr[0], max_val = arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i] < min_val) min_val = arr[i];
        if (arr[i] > max_val) max_val = arr[i];
    }

    if (min_val == max_val) return true;

    if ((max_val - min_val) % (size - 1) != 0) return false;

    int diff = (max_val - min_val) / (size - 1);

    int* seen = (int*)calloc(size, sizeof(int));
    for (int i = 0; i < size; i++) {
        if ((arr[i] - min_val) % diff != 0) {
            free(seen);
            return false;
        }
        int pos = (arr[i] - min_val) / diff;
        if (pos >= size || seen[pos]) {
            free(seen);
            return false;
        }
        seen[pos] = 1;
    }

    free(seen);
    return true;
}

bool* checkArithmeticSubarrays(int* nums, int numsSize, int* l, int lSize, int* r, int rSize, int* returnSize) {
    *returnSize = lSize;
    bool* result = (bool*)malloc(lSize * sizeof(bool));

    for (int i = 0; i < lSize; i++) {
        int left = l[i];
        int right = r[i];
        int subSize = right - left + 1;

        int* subarr = (int*)malloc(subSize * sizeof(int));
        for (int j = 0; j < subSize; j++) {
            subarr[j] = nums[left + j];
        }

        result[i] = check(subarr, subSize);
        free(subarr);
    }

    return result;
}