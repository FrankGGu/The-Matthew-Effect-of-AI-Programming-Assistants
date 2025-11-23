int cmp(const void *a, const void *b) {
    long long A = *(long long*)a;
    long long B = *(long long*)b;
    if (A > B) return 1;
    if (A < B) return -1;
    return 0;
}

int maximumBeauty(int* nums, int numsSize, int k) {
    long long *start = (long long*)malloc(numsSize * sizeof(long long));
    long long *end = (long long*)malloc(numsSize * sizeof(long long));

    for (int i = 0; i < numsSize; i++) {
        start[i] = (long long)nums[i] - k;
        end[i] = (long long)nums[i] + k;
    }

    qsort(start, numsSize, sizeof(long long), cmp);
    qsort(end, numsSize, sizeof(long long), cmp);

    int i = 0, j = 0;
    int count = 0, maxCount = 0;

    while (i < numsSize && j < numsSize) {
        if (start[i] <= end[j]) {
            count++;
            if (count > maxCount) {
                maxCount = count;
            }
            i++;
        } else {
            count--;
            j++;
        }
    }

    free(start);
    free(end);

    return maxCount;
}