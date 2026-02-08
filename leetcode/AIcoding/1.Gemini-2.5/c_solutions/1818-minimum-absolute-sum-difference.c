#include <stdlib.h> // For qsort, malloc, free, llabs

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int lower_bound_idx(int* arr, int n, int target) {
    int low = 0;
    int high = n - 1;
    int ans = n;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

long long minAbsoluteSumDiff(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long MOD = 1e9 + 7;
    long long initial_sum = 0;
    long long max_reduction = 0;

    int* sorted_nums1 = (int*)malloc(nums1Size * sizeof(int));
    for (int i = 0; i < nums1Size; i++) {
        sorted_nums1[i] = nums1[i];
    }
    qsort(sorted_nums1, nums1Size, sizeof(int), compare);

    for (int i = 0; i < nums1Size; i++) {
        long long diff_original = llabs((long long)nums1[i] - nums2[i]);
        initial_sum += diff_original;

        int target = nums2[i];
        int idx = lower_bound_idx(sorted_nums1, nums1Size, target);

        long long min_new_diff = diff_original;

        if (idx < nums1Size) {
            long long current_diff = llabs((long long)sorted_nums1[idx] - target);
            if (current_diff < min_new_diff) {
                min_new_diff = current_diff;
            }
        }
        if (idx > 0) {
            long long current_diff = llabs((long long)sorted_nums1[idx - 1] - target);
            if (current_diff < min_new_diff) {
                min_new_diff = current_diff;
            }
        }

        long long current_reduction = diff_original - min_new_diff;
        if (current_reduction > max_reduction) {
            max_reduction = current_reduction;
        }
    }

    free(sorted_nums1);

    long long result = (initial_sum - max_reduction);
    result = (result % MOD + MOD) % MOD;
    return result;
}