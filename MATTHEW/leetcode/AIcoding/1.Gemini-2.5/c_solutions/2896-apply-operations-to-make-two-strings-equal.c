#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long minCost(char * s1, char * s2, int x){
    int n = strlen(s1);

    // Collect all mismatch indices
    // Using a dynamically allocated array for diff_indices
    // Max size is n, but m can be smaller.
    int* diff_indices = (int*)malloc(n * sizeof(int));
    int m = 0; // Number of mismatches
    for (int i = 0; i < n; ++i) {
        if (s1[i] != s2[i]) {
            diff_indices[m++] = i;
        }
    }

    // If no mismatches, cost is 0
    if (m == 0) {
        free(diff_indices);
        return 0;
    }

    // Case 1: x >= 2
    // In this case, two single flips (cost 1+1=2) are always better or equal to one double flip (cost x).
    // So, it's always optimal to use single flips for all mismatches.
    // The cost is simply the number of mismatches.
    if (x >= 2) {
        free(diff_indices);
        return m;
    }

    // Case 2: x = 1
    // Both operations cost 1.
    // Operation 1 (double flip): fixes two mismatches for cost 1 (if s1[i] == s1[j]).
    // Operation 2 (single flip): fixes one mismatch for cost 1.
    // We want to maximize the use of Operation 1 because it resolves two mismatches for the same cost as one single flip.
    // The condition for Operation 1 is s1[i] == s1[j].
    // This means we can only pair two mismatches where s1[k] is '0' (and needs to become '1'),
    // or two mismatches where s1[k] is '1' (and needs to become '0').
    // We cannot pair a '0' mismatch with a '1' mismatch using Operation 1.
    // This effectively splits the problem into two independent subproblems:
    //   a) Mismatches where s1[k] == '0'
    //   b) Mismatches where s1[k] == '1'
    // For each subproblem, say there are 'count' mismatches.
    // Since any two can be paired, the maximum number of pairs we can form is `count / 2` (integer division).
    // The remaining `count % 2` mismatches must be fixed by single flips.
    // Each pair costs x (which is 1). Each single flip costs 1.
    // So, for 'count' mismatches, the total cost is `(count / 2) * x + (count % 2) * 1`.
    // Since x = 1, this simplifies to `(count / 2) + (count % 2)`.
    // This expression is equivalent to `ceil(count / 2.0)`, which for positive integers `count` can be computed as `(count + 1) / 2` using integer division.

    int m0_count = 0; // Count of mismatches where s1[k] == '0'
    int m1_count = 0; // Count of mismatches where s1[k] == '1'

    for (int i = 0; i < m; ++i) {
        int idx = diff_indices[i];
        if (s1[idx] == '0') {
            m0_count++;
        } else { // s1[idx] == '1'
            m1_count++;
        }
    }

    // Calculate cost for '0' mismatches and '1' mismatches separately
    long long cost_m0 = (long long)(m0_count + 1) / 2;
    long long cost_m1 = (long long)(m1_count + 1) / 2;

    free(diff_indices);
    return cost_m0 + cost_m1;
}