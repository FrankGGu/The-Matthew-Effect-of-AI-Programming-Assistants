#include <stdlib.h>
#include <string.h>
#include <limits.h> // Required for LLONG_MIN

char * stoneGameIII(int* stoneValue, int stoneValueSize) {
    int n = stoneValueSize;
    long long* dp = (long long*)malloc((n + 1) * sizeof(long long));

    // dp[i] represents the maximum score Alice can get relative to Bob
    // if the game starts from stones[i] to stones[n-1].
    // dp[n] is 0 because there are no stones left, so the score difference is 0.
    dp[n] = 0;

    // Iterate backwards from the last stone to the first
    for (int i = n - 1; i >= 0; --i) {
        long long current_sum = 0;
        // Initialize dp[i] with a very small number to ensure max operation works correctly
        dp[i] = LLONG_MIN; 

        // Alice can take 1, 2, or 3 stones
        for (int k = 0; k < 3; ++k) {
            // Check if there are enough stones to take (i + k must be a valid index)
            if (i + k < n) { 
                current_sum += stoneValue[i + k];

                // If Alice takes k+1 stones (from index i to i+k),
                // her score contribution for this turn is current_sum.
                // The game then continues from index i+k+1, and it's Bob's turn.
                // Bob will play optimally to maximize his score relative to Alice.
                // The value dp[i+k+1] represents Bob's optimal net score from that point
                // (Bob's score - Alice's score).
                // So, Alice's total net gain for this move is current_sum minus what Bob gets.
                long long next_dp_val = (i + k + 1 <= n) ? dp[i + k + 1] : 0;
                dp[i] = (dp[i] > current_sum - next_dp_val) ? dp[i] : (current_sum - next_dp_val);
            } else {
                // Not enough stones to take k+1 stones, so no more options for this 'i'
                break;
            }
        }
    }

    long long final_score_diff = dp[0]; // dp[0] is the final score difference for the entire game

    free(dp); // Free dynamically allocated memory

    char* result;
    if (final_score_diff > 0) {
        result = (char*)malloc(sizeof(char) * 6); // "Alice" + null terminator
        strcpy(result, "Alice");
    } else if (final_score_diff < 0) {
        result = (char*)malloc(sizeof(char) * 4); // "Bob" + null terminator
        strcpy(result, "Bob");
    } else {
        result = (char*)malloc(sizeof(char) * 4); // "Tie" + null terminator
        strcpy(result, "Tie");
    }
    return result;
}