int countFairPairs(int* nums, int numsSize, int lower, int upper) {
    int count = 0;
    int* sortedNums = (int*)malloc(numsSize * sizeof(int));
    memcpy(sortedNums, nums, numsSize * sizeof(int));
    qsort(sortedNums, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize; i++) {
        int leftBound = lower - nums[i];
        int rightBound = upper - nums[i];

        int leftIndex = lowerBound(sortedNums, numsSize, leftBound);
        int rightIndex = upperBound(sortedNums, numsSize, rightBound);

        count += rightIndex - leftIndex - (leftIndex <= i && i < rightIndex);
    }

    free(sortedNums);
    return count / 2;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int lowerBound(int* arr, int size, int target) {
    int left = 0, right = size;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] < target) left = mid + 1;
        else right = mid;
    }
    return left;
}

int upperBound(int* arr, int size, int target) {
    int left = 0, right = size;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] <= target) left = mid + 1;
        else right = mid;
    }
    return left;
}