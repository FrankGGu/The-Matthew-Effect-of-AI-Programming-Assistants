double findMedian(int* nums, int numsSize) {
    if (numsSize == 0) return 0.0;

    int unique[10001] = {0};
    int uniqueCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (unique[nums[i]] == 0) {
            unique[nums[i]] = 1;
            uniqueCount++;
        }
    }

    int* uniqueArr = (int*)malloc(uniqueCount * sizeof(int));
    int idx = 0;

    for (int i = 0; i < 10001; i++) {
        if (unique[i] == 1) {
            uniqueArr[idx++] = i;
        }
    }

    qsort(uniqueArr, uniqueCount, sizeof(int), cmp);

    double median;
    if (uniqueCount % 2 == 0) {
        median = (uniqueArr[uniqueCount / 2 - 1] + uniqueArr[uniqueCount / 2]) / 2.0;
    } else {
        median = uniqueArr[uniqueCount / 2];
    }

    free(uniqueArr);
    return median;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}