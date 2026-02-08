#include <stdlib.h> // For malloc
#include <string.h> // For memset
#include <limits.h> // For INT_MAX, INT_MIN

int memo[29][29][29][2]; // N is up to 28, so indices up to 28 are needed.

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

void solve(int num_players, int f_pos, int s_pos) {
    // Ensure f_pos is always less than s_pos for consistent memoization.
    // The problem statement guarantees firstPlayer < secondPlayer initially,
    // and their relative order is preserved due to re-numbering based on original values.
    if (f_pos > s_pos) {
        int temp = f_pos;
        f_pos = s_pos;
        s_pos = temp;
    }

    // Check if this state has already been computed.
    if (memo[num_players][f_pos][s_pos][0] != -1) {
        return; // Return if result is memoized.
    }

    // Base case: firstPlayer and secondPlayer compete in this round.
    // They compete if they are paired together. In a round with `num_players` players,
    // player `i` is paired with player `num_players - i + 1`.
    // So, if f_pos's partner is s_pos, they compete.
    if (f_pos + s_pos == num_players + 1) {
        memo[num_players][f_pos][s_pos][0] = 1; // It takes 1 more round.
        memo[num_players][f_pos][s_pos][1] = 1; // It takes 1 more round.
        return;
    }

    // If they don't compete in this round, they both must win and advance to the next round.
    // We need to simulate all possible outcomes for other matches to find min/max rounds.

    int current_min_total_rounds = INT_MAX; // Initialize with a very large value.
    int current_max_total_rounds = INT_MIN;   // Initialize with a very small value.

    // The number of matches in this round is `(num_players + 1) / 2`.
    // This is also the number of players in the next round.
    int next_num_players = (num_players + 1) / 2;

    // Iterate through all possible combinations of winners for the matches.
    // A bitmask `mask` is used, where each bit corresponds to a match (0-indexed).
    // The `i`-th match (1-indexed) involves players `i` and `num_players - i + 1`.
    // If bit `(i-1)` in the mask is 0, player `i` wins.
    // If bit `(i-1)` in the mask is 1, player `num_players - i + 1` wins.
    for (int mask = 0; mask < (1 << next_num_players); ++mask) {
        int next_f_pos_count = 0; // Counts winners whose original position is strictly less than f_pos.
        int next_s_pos_count = 0; // Counts winners whose original position is strictly less than s_pos.

        // Simulate the round to determine the new positions (next_f_pos, next_s_pos)
        // and the number of players in the next round.
        for (int i = 1; i <= next_num_players; ++i) { // `i` is the 1-indexed pair number
            int p1_in_match = i;
            int p2_in_match = num_players - i + 1;

            int winner_original_pos;

            // Determine the winner for this specific match (pair `(p1_in_match, p2_in_match)`).
            if (p1_in_match == f_pos || p2_in_match == f_pos) {
                // If firstPlayer is in this match, it must win.
                winner_original_pos = f_pos;
            } else if (p1_in_match == s_pos || p2_in_match == s_pos) {
                // If secondPlayer is in this match, it must win.
                winner_original_pos = s_pos;
            } else {
                // For other matches, the winner is chosen based on the current bit in the mask.
                if ((mask >> (i - 1)) & 1) { // If bit is 1, the right player wins.
                    winner_original_pos = p2_in_match;
                } else { // If bit is 0, the left player wins.
                    winner_original_pos = p1_in_match;
                }
            }

            // Update the counts for `next_f_pos` and `next_s_pos`.
            // The new 1-indexed position of a player is `1 + (count of winners with smaller original positions)`.
            if (winner_original_pos < f_pos) {
                next_f_pos_count++;
            }
            if (winner_original_pos < s_pos) {
                next_s_pos_count++;
            }
        }

        // Add 1 to the counts to get the actual 1-indexed positions in the next round.
        // This accounts for f_pos and s_pos themselves, as they are guaranteed to win.
        int next_f_pos = next_f_pos_count + 1;
        int next_s_pos = next_s_pos_count + 1;

        // Recursively call for the next round.
        solve(next_num_players, next_f_pos, next_s_pos);

        // Retrieve the results from the recursive call.
        int res_min = memo[next_num_players][next_f_pos][next_s_pos][0];
        int res_max = memo[next_num_players][next_f_pos][next_s_pos][1];

        // Update the overall min and max rounds for the current state.
        current_min_total_rounds = min(current_min_total_rounds, 1 + res_min);
        current_max_total_rounds = max(current_max_total_rounds, 1 + res_max);
    }

    // Store the computed results in the memoization table.
    memo[num_players][f_pos][s_pos][0] = current_min_total_rounds;
    memo[num_players][f_pos][s_pos][1] = current_max_total_rounds;
}

int* earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
    // Initialize the memoization table with -1 (indicating uncomputed states).
    // The maximum possible value for n, firstPlayer, secondPlayer is 28.
    // So, array size 29 (for indices 0-28) is appropriate.
    for (int i = 0; i <= n; ++i) {
        for (int j = 0; j <= n; ++j) {
            for (int k = 0; k <= n; ++k) {
                memo[i][j][k][0] = -1;
                memo[i][j][k][1] = -1;
            }
        }
    }

    // Start the recursive computation from the initial state.
    solve(n, firstPlayer, secondPlayer);

    // Allocate memory for the result array.
    int* result = (int*)malloc(sizeof(int) * 2);
    // Retrieve the computed earliest and latest rounds for the initial state.
    result[0] = memo[n][firstPlayer][secondPlayer][0];
    result[1] = memo[n][firstPlayer][secondPlayer][1];

    return result;
}