#include <stdlib.h>
#include <stdio.h>
#include <math.h> // For abs

static inline int min(int a, int b) {
    return a < b ? a : b;
}

static inline int min3(int a, int b, int c) {
    return min(a, min(b, c));
}

static inline int d_circ(int a, int b, int n) {
    int diff = abs(a - b);
    return min(diff, n - diff);
}

long long* countHouses(int n, int x, int y, int* returnSize) {
    *returnSize = n; // The problem asks for an array of size n, where ans[k-1] is for distance k.

    // ans_counts array will store counts for distances 1 to n-1.
    // Max possible distance is n/2.
    // We use n+1 size for 1-based indexing for distances.
    long long* ans_counts = (long long*) calloc(n + 1, sizeof(long long));
    if (ans_counts == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 1; i <= n; ++i) {
        for (int j = i + 1; j <= n; ++j) {
            // Path 1: Direct circular path between i and j
            int path1_dist = d_circ(i, j, n);

            // Path 2: i -> x -> y -> j
            int path2_dist = d_circ(i, x, n) + 1 + d_circ(y, j, n);

            // Path 3: i -> y -> x -> j
            int path3_dist = d_circ(i, y, n) + 1 + d_circ(x, j, n);

            // The shortest distance is the minimum of these three paths
            int shortest_dist = min3(path1_dist, path2_dist, path3_dist);

            // Increment the count for this shortest distance
            // Distances are from 1 to n-1, max is n/2.
            // We only care about distances up to n-1.
            if (shortest_dist >= 1 && shortest_dist < n) { 
                ans_counts[shortest_dist]++;
            }
        }
    }

    // The problem asks for an array of size n, where result[k-1] is the count for distance k.
    // So, copy counts from ans_counts[1...n-1] to result[0...n-2].
    long long* result = (long long*) calloc(n, sizeof(long long));
    if (result == NULL) {
        free(ans_counts);
        *returnSize = 0;
        return NULL;
    }

    for (int k = 1; k < n; ++k) {
        result[k - 1] = ans_counts[k];
    }

    free(ans_counts);
    return result;
}