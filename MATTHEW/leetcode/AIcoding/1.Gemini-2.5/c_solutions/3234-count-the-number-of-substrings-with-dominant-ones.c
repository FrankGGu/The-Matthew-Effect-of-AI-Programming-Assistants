#include <string.h>
#include <stdlib.h>

static void update(int* bit, int bit_size, int idx, int val) {
    idx++; // Convert to 1-indexed for BIT
    while (idx <= bit_size) {
        bit[idx] += val;
        idx += idx & (-idx);
    }
}

static int query(int* bit, int bit_size, int idx) {
    idx++; // Convert to 1-indexed for BIT
    int sum = 0;
    while (idx > 0) {
        sum += bit[idx];
        idx -= idx & (-idx);
    }
    return sum;
}

long long numberOfSubstrings(char* s) {
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    // The range of prefix sums (count_ones - count_zeros) is [-n, n].
    // We need to map these to non-negative indices for the BIT.
    // Offset = n. Mapped range [0, 2n].
    // BIT array size needs to be 2n + 1 (for 0 to 2n, inclusive).
    // Using 1-indexing for BIT, so array size will be (2n + 1) + 1.
    int bit_array_size = 2 * n + 1;
    int* bit_array = (int*)calloc(bit_array_size + 1, sizeof(int));
    if (bit_array == NULL) {
        return 0; 
    }

    int offset = n; // Offset to map prefix sums to non-negative indices

    long long total_count = 0;
    int current_prefix_sum = 0; // Represents prefix_sum[0] (sum of empty prefix)

    // Initialize BIT with the count for prefix_sum[0] (which is 0)
    // Mapped index: 0 + offset
    update(bit_array, bit_array_size, current_prefix_sum + offset, 1);

    for (int j = 0; j < n; j++) {
        if (s[j] == '1') {
            current_prefix_sum++;
        } else { // s[j] == '0'
            current_prefix_sum--;
        }

        // For the current prefix sum ending at j (current_prefix_sum),
        // we need to find how many previous prefix sums (prefix_sum[i] for i <= j)
        // satisfy prefix_sum[i] <= current_prefix_sum.
        // This is equivalent to querying the BIT for the sum of frequencies
        // from the minimum possible mapped prefix sum (0) up to the
        // current mapped prefix sum (current_prefix_sum + offset).
        total_count += query(bit_array, bit_array_size, current_prefix_sum + offset);

        // Add the current prefix sum to the BIT for future calculations
        update(bit_array, bit_array_size, current_prefix_sum + offset, 1);
    }

    free(bit_array);
    return total_count;
}