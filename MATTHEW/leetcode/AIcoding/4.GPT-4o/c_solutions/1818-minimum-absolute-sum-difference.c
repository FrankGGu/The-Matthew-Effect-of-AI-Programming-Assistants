#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MOD 1000000007

int minAbsoluteSumDiff(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long totalDiff = 0, maxGain = 0;
    int* sortedNums1 = malloc(nums1Size * sizeof(int));
    memcpy(sortedNums1, nums1, nums1Size * sizeof(int));
    qsort(sortedNums1, nums1Size, sizeof(int), cmpfunc);

    for (int i = 0; i < nums1Size; ++i) {
        totalDiff += abs(nums1[i] - nums2[i]);
    }

    for (int i = 0; i < nums1Size; ++i) {
        int target = nums2[i];
        int left = 0, right = nums1Size - 1, best = nums1[i];

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sortedNums1[mid] < target) {
                best = sortedNums1[mid];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        long long gain = abs(nums1[i] - target) - abs(best - target);
        maxGain = MAX(maxGain, gain);

        if (left < nums1Size) {
            gain = abs(nums1[i] - target) - abs(sortedNums1[left] - target);
            maxGain = MAX(maxGain, gain);
        }
    }

    free(sortedNums1);
    return (totalDiff - maxGain) % MOD;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}