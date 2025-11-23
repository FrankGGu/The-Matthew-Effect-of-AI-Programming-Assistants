#include <stdlib.h> // For malloc, qsort, labs

long long min_ll(long long a, long long b) {
    return (a < b) ? a : b;
}

int compare_long_long(const void* a, const void* b) {
    long long val_a = *(long long*)a;
    long long val_b = *(long long*)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

void generate_sums(int* nums, int idx, int limit, long long current_sum, long long* sums, int* count) {
    if (idx == limit) {
        sums[(*count)++] = current_sum;
        return;
    }

    generate_sums(nums, idx + 1, limit, current_sum + nums[idx], sums, count);
    generate_sums(nums, idx + 1, limit, current_sum, sums, count);
}

int minAbsDifference(int* nums, int numsSize, int goal) {
    int n = numsSize;
    int mid = n / 2;

    long long* sums1 = (long long*)malloc(sizeof(long long) * (1 << mid));
    int sums1_count = 0;
    generate_sums(nums, 0, mid, 0, sums1, &sums1_count);

    long long* sums2 = (long long*)malloc(sizeof(long long) * (1 << (n - mid)));
    int sums2_count = 0;
    generate_sums(nums, mid, n, 0, sums2, &sums2_count);

    qsort(sums2, sums2_count, sizeof(long long), compare_long_long);

    long long min_diff = labs((long long)goal);

    for (int i = 0; i < sums1_count; i++) {
        long long s1 = sums1[i];
        long long target = (long long)goal - s1;

        int low = 0;
        int high = sums2_count - 1;

        while (low <= high) {
            int mid_idx = low + (high - low) / 2;
            long long s2 = sums2[mid_idx];

            min_diff = min_ll(min_diff, labs(s1 + s2 - goal));

            if (s2 < target) {
                low = mid_idx + 1;
            } else if (s2 > target) {
                high = mid_idx - 1;
            } else {
                min_diff = 0;
                goto end_loops;
            }
        }

        if (low < sums2_count) {
            min_diff = min_ll(min_diff, labs(s1 + sums2[low] - goal));
        }
        if (high >= 0) {
            min_diff = min_ll(min_diff, labs(s1 + sums2[high] - goal));
        }
    }

end_loops:;

    free(sums1);
    free(sums2);

    return (int)min_diff;
}