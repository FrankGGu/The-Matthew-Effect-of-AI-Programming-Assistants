int compare(const void* a, const void* b) {
    long long diff = (*(long long*)a - *(long long*)b);
    return (diff > 0) ? 1 : (diff < 0) ? -1 : 0;
}

long long largestPerimeter(int* nums, int numsSize) {
    long long* sorted = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }

    qsort(sorted, numsSize, sizeof(long long), compare);

    long long prefixSum = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSum += sorted[i];
    }

    for (int i = numsSize - 1; i >= 2; i--) {
        prefixSum -= sorted[i];
        if (prefixSum > sorted[i]) {
            free(sorted);
            return prefixSum + sorted[i];
        }
    }

    free(sorted);
    return -1;
}