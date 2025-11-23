#include <stdlib.h> // For qsort

int compareLongLongDesc(const void *a, const void *b) {
    long long valA = *(const long long *)a;
    long long valB = *(const long long *)b;
    if (valA < valB) return 1; // valA comes after valB for descending sort
    if (valA > valB) return -1; // valA comes before valB for descending sort
    return 0;
}

int minimumTime(int* nums1, int nums1Size, int* nums2, int nums2Size, int x) {
    int n = nums1Size;

    long long sum_nums1_all = 0;
    long long sum_nums2_all = 0;

    // Calculate initial sums of all elements in nums1 and nums2
    for (int i = 0; i < n; i++) {
        sum_nums1_all += nums1[i];
        sum_nums2_all += nums2[i];
    }

    // Check for k=0 (no items cleared)
    // The total sum at time 0 is just the sum of nums1.
    if (sum_nums1_all <= x) {
        return 0;
    }

    // Allocate memory for temporary array to store values for sorting.
    // This array will be re-populated for each 'k'.
    long long* current_values = (long long*)malloc(n * sizeof(long long));
    // In competitive programming, malloc failure is usually ignored for constraints.
    // For robust code, one would check for NULL.

    // Iterate 'k' from 1 to n.
    // 'k' represents the number of items we choose to clear,
    // and also the total time elapsed.
    for (int k = 1; k <= n; k++) {
        // For each item 'p', calculate its contribution to the sum if NOT cleared at time 'k'.
        // Or, equivalently, the amount reduced if cleared at time 'k'.
        // This value is nums1[p] + k * nums2[p].
        for (int p = 0; p < n; p++) {
            current_values[p] = (long long)nums1[p] + (long long)k * nums2[p];
        }

        // Sort 'current_values' in descending order.
        // We want to maximize the reduction, so we pick the 'k' largest values.
        qsort(current_values, n, sizeof(long long), compareLongLongDesc);

        long long reduction_k = 0;
        // Sum the top 'k' largest values from 'current_values'.
        // These are the 'k' items chosen to be cleared.
        for (int p = 0; p < k; p++) {
            reduction_k += current_values[p];
        }

        // Calculate the total sum if no items were cleared at time 'k':
        // (sum_nums1_all + k * sum_nums2_all)
        // Then subtract the maximum possible reduction achieved by clearing 'k' items:
        // current_sum = (total sum if no items cleared) - (max reduction by clearing k items)
        long long current_sum = (sum_nums1_all + (long long)k * sum_nums2_all) - reduction_k;

        // If the current sum is at most 'x', then 'k' is the minimum time.
        if (current_sum <= x) {
            free(current_values);
            return k;
        }
    }

    // Free allocated memory
    free(current_values);

    // This line should theoretically not be reached because when k=n,
    // reduction_k will be (sum_nums1_all + n * sum_nums2_all),
    // making current_sum = 0, which is always <= x (since x >= 0).
    return n;
}