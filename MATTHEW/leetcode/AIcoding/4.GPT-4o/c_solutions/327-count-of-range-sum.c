#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int merge(int* sums, int start, int mid, int end, long long low, long long high) {
    int count = 0;
    int j = mid + 1, k = mid + 1;
    for (int i = start; i <= mid; i++) {
        while (j <= end && sums[j] - sums[i] < low) j++;
        while (k <= end && sums[k] - sums[i] <= high) k++;
        count += (k - j);
    }
    int* temp = (int*)malloc((end - start + 1) * sizeof(int));
    int idx = 0, left = start, right = mid + 1;
    while (left <= mid && right <= end) {
        if (sums[left] <= sums[right]) {
            temp[idx++] = sums[left++];
        } else {
            temp[idx++] = sums[right++];
        }
    }
    while (left <= mid) temp[idx++] = sums[left++];
    while (right <= end) temp[idx++] = sums[right++];
    for (int i = 0; i < idx; i++) {
        sums[start + i] = temp[i];
    }
    free(temp);
    return count;
}

int countRangeSum(int* nums, int numsSize, long long lower, long long upper) {
    int* sums = (int*)malloc((numsSize + 1) * sizeof(int));
    sums[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        sums[i + 1] = sums[i] + nums[i];
    }
    int count = 0;
    count = mergeSort(sums, 0, numsSize, lower, upper);
    free(sums);
    return count;
}

int mergeSort(int* sums, int start, int end, long long low, long long high) {
    if (start >= end) return 0;
    int mid = start + (end - start) / 2;
    int count = mergeSort(sums, start, mid, low, high) + mergeSort(sums, mid + 1, end, low, high);
    count += merge(sums, start, mid, end, low, high);
    return count;
}