#include <vector>
#include <numeric> // For std::accumulate or sum calculation

class Solution {
public:
    int N; // maxChoosableInteger
    int T; // desiredTotal
    std::vector<char> memo; // -1: uncomputed, 0: false (current player loses), 1: true (current player wins)

    bool canIWin(int maxChoosableInteger, int desiredTotal) {
        N = maxChoosableInteger;
        T = desiredTotal;

        // Edge case: If desiredTotal is 0 or less, the first player wins immediately without choosing any numbers.
        if (T <= 0) {
            return true;
        }

        // If the sum of all available numbers is less than desiredTotal,
        // it's impossible for anyone to reach the desired total.
        // In this scenario, the first player cannot win.
        int totalSum = N * (N + 1) / 2;
        if (totalSum < T) {
            return false;
        }

        // Initialize memoization table.
        // The size is 2^N, representing all possible combinations of chosen numbers.
        // Each entry stores a char: -1 for uncomputed, 0 for false, 1 for true.
        memo.assign(1 << N, -1);

        // Start the game from an empty set of chosen numbers (mask 0) and a current sum of 0.
        return solve(0, 0);
    }

    // solve returns true if the current player can win from the given state.
    // chosenMask: A bitmask where the i-th bit is set if number (i+1) has been chosen.
    // currentSum: The sum of numbers already chosen (represented by chosenMask).
    bool solve(int chosenMask, int currentSum) {
        // Check if this state has already been computed.
        if (memo[chosenMask] != -1) {
            return memo[chosenMask] == 1;
        }

        // Iterate through all possible numbers the current player can choose.
        for (int i = 1; i <= N; ++i) {
            // Check if number 'i' has not yet been chosen.
            // (i-1) is used for bit shifting because numbers are 1-indexed.
            if (!((chosenMask >> (i - 1)) & 1)) {
                // If choosing 'i' makes the current sum reach or exceed desiredTotal,
                // the current player wins immediately.
                if (currentSum + i >= T) {
                    memo[chosenMask] = 1; // Mark this state as winning for the current player
                    return true;
                }

                // If choosing 'i' does not immediately win, it becomes the opponent's turn.
                // We recursively call solve for the new state (with 'i' chosen and sum updated).
                // If the opponent CANNOT win from this new state, it means the current player WINS
                // by making this move.
                if (!solve(chosenMask | (1 << (i - 1)), currentSum + i)) {
                    memo[chosenMask] = 1; // Mark this state as winning for the current player
                    return true;
                }
            }
        }

        // If the loop finishes, it means no move leads to a win for the current player.
        // Therefore, the current player loses from this state.
        memo[chosenMask] = 0; // Mark this state as losing for the current player
        return false;
    }
};