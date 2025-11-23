#include <limits.h> // Required for INT_MIN

int max(int a, int b) {
    return a > b ? a : b;
}

int maxScoreSightseeingPair(int* values, int valuesSize) {
    // The expression to maximize is values[i] + values[j] + i - j where i < j.
    // This can be rewritten as (values[i] + i) + (values[j] - j).
    // We iterate through j from 1 to valuesSize - 1.
    // For each j, we need to find the maximum (values[i] + i) for all i < j.

    // max_A_plus_i stores the maximum value of (values[k] + k) for k < current j.
    // Initialize with the first element's contribution (for i=0).
    int max_A_plus_i = values[0] + 0;

    // overall_max_score stores the maximum score found so far.
    // Initialize with a sufficiently small number (INT_MIN) because scores can be negative
    // (e.g., [1, 100000], N=100000, A[0]=1, A[N-1]=1, score = 1+1+0-(N-1) = 2-(N-1) which is negative).
    // Although in this problem, A[i] >= 1, so the minimum score for N=2 is 1+1+0-1 = 1.
    // For larger N, e.g., N=10^5, A=[1,1,...,1], score for (0, N-1) is 1+1+0-(N-1) = 2 - (10^5 - 1) which is negative.
    // So INT_MIN is a safe initialization.
    int overall_max_score = INT_MIN;

    // Iterate j from 1 to valuesSize - 1 (since i must be less than j, j starts from 1).
    for (int j = 1; j < valuesSize; j++) {
        // At the start of this iteration, max_A_plus_i holds max(values[k] + k) for k in [0, j-1].
        // Calculate the score for the current j using the best i found so far.
        int current_pair_score = max_A_plus_i + (values[j] - j);

        // Update the overall maximum score.
        overall_max_score = max(overall_max_score, current_pair_score);

        // Update max_A_plus_i to include values[j] for the next iteration (j+1).
        // This ensures max_A_plus_i will correctly represent max(values[k] + k) for k in [0, j].
        max_A_plus_i = max(max_A_plus_i, values[j] + j);
    }

    return overall_max_score;
}