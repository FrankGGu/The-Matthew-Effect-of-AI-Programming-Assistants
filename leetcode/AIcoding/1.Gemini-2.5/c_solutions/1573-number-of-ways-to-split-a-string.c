#include <string.h>
#include <stdlib.h>

long long numWays(char * s){
    int n = strlen(s);
    long long totalOnes = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            totalOnes++;
        }
    }

    long long MOD = 1e9 + 7;

    if (totalOnes % 3 != 0) {
        return 0;
    }

    if (totalOnes == 0) {
        // If all characters are '0', we need to choose two split points
        // from n-1 possible positions (indices 1 to n-1).
        // This is (n-1) choose 2 ways.
        // If n < 3, (n-1)*(n-2) will be 0 or negative, resulting in 0, which is correct.
        return (long long)(n - 1) * (n - 2) / 2 % MOD;
    }

    // Case: totalOnes > 0 and divisible by 3
    long long targetOnes = totalOnes / 3;

    // Store 0-indexed positions of all '1's
    int* one_indices = (int*)malloc(totalOnes * sizeof(int));
    if (one_indices == NULL) {
        // Handle allocation failure, though typically not an issue on LeetCode
        return -1; 
    }

    int currentOneCount = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            one_indices[currentOneCount++] = i;
        }
    }

    // Calculate ways for the first split point
    // The first part s1 must contain 'targetOnes' number of '1's.
    // The 'targetOnes'-th '1' is at one_indices[targetOnes - 1].
    // The '(targetOnes + 1)'-th '1' is at one_indices[targetOnes].
    // The first split can occur anywhere between these two '1's.
    // The number of positions for the first split is the difference of their indices.
    long long ways_for_p1 = one_indices[targetOnes] - one_indices[targetOnes - 1];

    // Calculate ways for the second split point
    // The first two parts (s1+s2) must contain '2 * targetOnes' number of '1's.
    // The '(2 * targetOnes)'-th '1' is at one_indices[2 * targetOnes - 1].
    // The '(2 * targetOnes + 1)'-th '1' is at one_indices[2 * targetOnes].
    // The second split can occur anywhere between these two '1's.
    long long ways_for_p2 = one_indices[2 * targetOnes] - one_indices[2 * targetOnes - 1];

    free(one_indices);

    return (ways_for_p1 * ways_for_p2) % MOD;
}