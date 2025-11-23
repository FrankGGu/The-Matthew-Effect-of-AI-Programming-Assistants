#include <stdlib.h> // For malloc
#include <string.h> // Not strictly needed, but common for string operations

static long long combinations[31][31];
static int combinations_precomputed = 0;

static void precompute_combinations() {
    if (combinations_precomputed) {
        return;
    }

    for (int i = 0; i <= 30; ++i) {
        combinations[i][0] = 1; // C(i, 0) = 1
        for (int j = 1; j <= i; ++j) {
            // Pascal's identity: C(n, k) = C(n-1, k-1) + C(n-1, k)
            combinations[i][j] = combinations[i-1][j-1] + combinations[i-1][j];
        }
    }
    combinations_precomputed = 1;
}

char* kthSmallestPath(int* target, int targetSize, int k) {
    precompute_combinations(); // Ensure combinations are precomputed

    int row = target[0];
    int col = target[1];

    int remaining_h = col; // Number of 'H' instructions left to place
    int remaining_v = row; // Number of 'V' instructions left to place

    int total_length = row + col;
    char* result = (char*)malloc(sizeof(char) * (total_length + 1));
    int current_idx = 0;

    for (int i = 0; i < total_length; ++i) {
        if (remaining_h > 0) {
            // Calculate the number of paths that start with 'H' at this point.
            // If we place 'H', we need to complete the path with (remaining_h - 1) 'H's
            // and (remaining_v) 'V's in (remaining_h - 1 + remaining_v) total remaining positions.
            long long ways_if_h = combinations[remaining_h - 1 + remaining_v][remaining_h - 1];

            if (k <= ways_if_h) {
                // The Kth path starts with 'H'
                result[current_idx++] = 'H';
                remaining_h--;
            } else {
                // The Kth path starts with 'V'
                result[current_idx++] = 'V';
                remaining_v--;
                k -= ways_if_h; // Adjust k to find the (k - ways_if_h)th path among those starting with 'V'
            }
        } else {
            // No more 'H' instructions left, must place 'V'
            result[current_idx++] = 'V';
            remaining_v--;
        }
    }
    result[current_idx] = '\0'; // Null-terminate the string

    return result;
}