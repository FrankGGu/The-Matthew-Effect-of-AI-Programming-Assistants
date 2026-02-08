typedef struct {
    int* arr;
    int size;
} IntArray;

IntArray minSubsequence(int* nums, int numsSize, int* returnSize) {
    IntArray result;
    result.arr = (int*)malloc(numsSize * sizeof(int));
    result.size = 0;

    int totalSum = 0, subsequenceSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    qsort(nums, numsSize, sizeof(int), (int(*)(const void*, const void*))compare);

    for (int i = 0; i < numsSize; i++) {
        subsequenceSum += nums[i];
        result.arr[result.size++] = nums[i];
        if (subsequenceSum > totalSum - subsequenceSum) {
            break;
        }
    }

    *returnSize = result.size;
    return result;
}

int compare(const int* a, const int* b) {
    return (*b - *a);
}