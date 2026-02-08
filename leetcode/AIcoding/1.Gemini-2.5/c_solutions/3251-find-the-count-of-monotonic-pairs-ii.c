#include <stdlib.h>
#include <string.h>

static int* bit_arr;
static int bit_arr_size;

static void bit_init(int size) {
    bit_arr_size = size + 1; // 1-based indexing for BIT
    bit_arr = (int*)calloc(bit_arr_size, sizeof(int));
}

static void bit_update(int idx, int val) {
    // idx is 0-based rank, convert to 1-based for BIT
    for (++idx; idx < bit_arr_size; idx += idx & -idx) {
        bit_arr[idx] += val;
    }
}

static int bit_query(int idx) {
    // idx is 0-based rank, convert to 1-based for BIT
    int sum = 0;
    for (++idx; idx > 0; idx -= idx & -idx) {
        sum += bit_arr[idx];
    }
    return sum;
}

static int compareLongLong(const void* a, const void* b) {
    long long val_a = *(long long*)a;
    long long val_b = *(long long*)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

static int lower_bound(long long* arr, int size, long long target) {
    int low = 0;
    int high = size; // exclusive upper bound
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] < target) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

long long countMonotonicPairs(int* nums, int numsSize, int k) {
    if (numsSize <= 1) {
        return 0;
    }

    // 1. Coordinate compression
    // Collect all relevant values: nums[i] and nums[i] - k
    // Max size is 2 * numsSize
    long long* coords = (long long*)malloc(2 * numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        coords[i] = nums[i];
        coords[i + numsSize] = (long long)nums[i] - k;
    }

    // Sort and remove duplicates
    qsort(coords, 2 * numsSize, sizeof(long long), compareLongLong);

    int unique_count = 0;
    if (2 * numsSize > 0) {
        coords[unique_count++] = coords[0];
        for (int i = 1; i < 2 * numsSize; i++) {
            if (coords[i] != coords[i-1]) {
                coords[unique_count++] = coords[i];
            }
        }
    }

    // Initialize Fenwick Tree with size based on unique_count
    bit_init(unique_count);

    long long total_pairs = 0;

    // 2. Iterate through original nums and use BIT
    for (int i = 0; i < numsSize; i++) {
        long long current_num = nums[i];
        long long lower_bound_val = current_num - k;

        // Find ranks for current_num and lower_bound_val in the compressed coordinate space
        // rank_val_i is the 0-based index of current_num in unique_sorted_coords
        int rank_val_i = lower_bound(coords, unique_count, current_num);

        // rank_lower_bound is the 0-based index of the first element >= lower_bound_val in unique_sorted_coords
        int rank_lower_bound = lower_bound(coords, unique_count, lower_bound_val);

        // Query BIT for count of elements in range [lower_bound_val, current_num]
        // This corresponds to ranks [rank_lower_bound, rank_val_i]
        // The query needs to be `bit_query(upper_rank) - bit_query(lower_rank - 1)`
        total_pairs += bit_query(rank_val_i) - (rank_lower_bound > 0 ? bit_query(rank_lower_bound - 1) : 0);

        // Update BIT to add current_num (at its corresponding rank)
        bit_update(rank_val_i, 1);
    }

    // Free allocated memory
    free(coords);
    free(bit_arr); // Free the global bit_arr

    return total_pairs;
}