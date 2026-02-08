int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int minAbsoluteDifference(int* nums, int numsSize, int x) {
    if (x == 0) return 0;

    int *sorted = (int*)malloc(numsSize * sizeof(int));
    int *indices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
        indices[i] = i;
    }

    qsort(sorted, numsSize, sizeof(int), cmp);

    int min_diff = INT_MAX;
    for (int i = 0; i < numsSize; i++) {
        int target = nums[i];
        int left = 0, right = numsSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sorted[mid] == target) {
                left = mid;
                break;
            } else if (sorted[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        int pos = left;
        for (int j = pos; j < numsSize; j++) {
            if (abs(i - indices[j]) >= x) {
                int diff = abs(sorted[j] - target);
                if (diff < min_diff) min_diff = diff;
                break;
            }
        }
        for (int j = pos - 1; j >= 0; j--) {
            if (abs(i - indices[j]) >= x) {
                int diff = abs(sorted[j] - target);
                if (diff < min_diff) min_diff = diff;
                break;
            }
        }
    }

    free(sorted);
    free(indices);
    return min_diff;
}