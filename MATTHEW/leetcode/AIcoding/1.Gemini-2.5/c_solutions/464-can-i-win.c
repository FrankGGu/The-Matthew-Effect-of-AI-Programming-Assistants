#include <stdbool.h>
#include <string.h> // For memset

int memo[1 << 20];
int MAX_CHOOSABLE_INT_GLOBAL;
int DESIRED_TOTAL_GLOBAL;

bool canWinRecursive(int mask, int currentSum) {
    // If the current sum already reaches or exceeds the desired total,
    // it means the player who made the *last* move (the opponent) won.
    // So, the current player cannot win from this state.
    if (currentSum >= DESIRED_TOTAL_GLOBAL) {
        return false;
    }

    // Check if this state has been computed before
    if (memo[mask] != 0) {
        return memo[mask] == 1;
    }

    // Iterate through all possible numbers the current player can choose
    for (int i = 1; i <= MAX_CHOOSABLE_INT_GLOBAL; ++i) {
        // Check if number 'i' has not been chosen yet
        // (i-1) is used because bit 0 represents number 1, bit 1 represents number 2, etc.
        if (!((mask >> (i - 1)) & 1)) {
            // If the current player chooses 'i':
            // The new mask will have the (i-1)-th bit set.
            // The new sum will be currentSum + i.
            // Then it's the opponent's turn.
            // If the opponent *cannot* win from this new state,
            // then the current player *can* win by choosing 'i'.
            if (!canWinRecursive(mask | (1 << (i - 1)), currentSum + i)) {
                memo[mask] = 1; // Mark current state as a winning state for the current player
                return true;
            }
        }
    }

    // If no move leads to a win for the current player, they lose from this state.
    memo[mask] = -1; // Mark current state as a losing state for the current player
    return false;
}

bool canIWin(int maxChoosableInteger, int desiredTotal) {
    // Edge case 1: If desiredTotal is 0 or less, the first player wins immediately.
    if (desiredTotal <= 0) {
        return true;
    }

    // Edge case 2: If the sum of all available numbers (1 to maxChoosableInteger)
    // is less than desiredTotal, it's impossible for anyone to reach desiredTotal.
    // In this scenario, the first player cannot win.
    // Sum of 1 to N is N * (N + 1) / 2.
    int totalPossibleSum = maxChoosableInteger * (maxChoosableInteger + 1) / 2;
    if (totalPossibleSum < desiredTotal) {
        return false;
    }

    // Initialize global variables for the current test case.
    MAX_CHOOSABLE_INT_GLOBAL = maxChoosableInteger;
    DESIRED_TOTAL_GLOBAL = desiredTotal;

    // Reset the memoization table for each test case.
    // All entries are set to 0 (uncomputed).
    memset(memo, 0, sizeof(memo));

    // Start the recursive game from an initial state:
    // No numbers chosen (mask = 0) and current sum is 0.
    // This call determines if the first player can win.
    return canWinRecursive(0, 0);
}