#include <stdlib.h> // For malloc, calloc

void backtrack(int k, int remainingArrows, int currentScore, int* currentBobArrows, int* aliceArrows, int* maxScore, int* bestBobArrows) {
    // Base case: All scores considered (from 11 down to 0)
    if (k < 0) {
        if (currentScore > *maxScore) {
            *maxScore = currentScore;
            // Copy the current best distribution
            for (int i = 0; i < 12; i++) {
                bestBobArrows[i] = currentBobArrows[i];
            }
            // Distribute any remaining arrows to score 0 (doesn't affect points)
            // This ensures all arrows are used if possible, or at least a valid distribution sum <= numArrows
            bestBobArrows[0] += remainingArrows;
        }
        return;
    }

    // Option 1: Bob tries to win score k
    // To win score k, Bob needs aliceArrows[k] + 1 arrows
    if (remainingArrows >= aliceArrows[k] + 1) {
        currentBobArrows[k] = aliceArrows[k] + 1;
        backtrack(k - 1, remainingArrows - (aliceArrows[k] + 1), currentScore + k, currentBobArrows, aliceArrows, maxScore, bestBobArrows);
        currentBobArrows[k] = 0; // Backtrack: reset for other paths
    }

    // Option 2: Bob does not win score k (or doesn't have enough arrows to win it)
    // In this case, Bob shoots 0 arrows at score k
    currentBobArrows[k] = 0; // Explicitly set to 0 for this path
    backtrack(k - 1, remainingArrows, currentScore, currentBobArrows, aliceArrows, maxScore, bestBobArrows);
}

int* maximumBobPoints(int numArrows, int* aliceArrows, int aliceArrowsSize, int* returnSize) {
    int maxScore = -1; // Initialize with a value lower than any possible score (minimum score is 0)

    // Allocate memory for the result array and initialize to 0
    int* bestBobArrows = (int*)calloc(12, sizeof(int));
    if (bestBobArrows == NULL) {
        // Handle memory allocation failure
        *returnSize = 0;
        return NULL;
    }

    // Temporary array for current path, also initialized to 0
    int currentBobArrows[12] = {0}; 

    // Start backtracking from the highest score (11) down to 0
    // Pass pointers to maxScore and bestBobArrows
    backtrack(11, numArrows, 0, currentBobArrows, aliceArrows, &maxScore, bestBobArrows);

    *returnSize = 12;
    return bestBobArrows;
}