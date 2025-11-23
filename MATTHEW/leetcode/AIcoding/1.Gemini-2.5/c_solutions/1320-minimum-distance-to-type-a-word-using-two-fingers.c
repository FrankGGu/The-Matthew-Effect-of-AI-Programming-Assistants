#include <string.h>
#include <stdlib.h> // For abs
#include <limits.h> // For INT_MAX

#define MIN(a, b) ((a) < (b) ? (a) : (b))

int get_dist(int p1, int p2) {
    int r1 = p1 / 5;
    int c1 = p1 % 5;
    int r2 = p2 / 5;
    int c2 = p2 % 5;
    return abs(r1 - r2) + abs(c1 - c2);
}

int minimumDistance(char* word) {
    int n = strlen(word);
    if (n <= 1) {
        return 0;
    }

    // dp[i][j] represents the minimum distance to type word[0...i],
    // where one finger is currently at word[i]-'A' and the other finger is at position j.
    // j can be 0-25 (representing a character 'A'-'Z') or 26 (representing an unplaced finger).
    // We use two rows for space optimization: dp[current_row][j] and dp[previous_row][j].
    int dp[2][27]; // 2 rows, 27 columns (0-25 for chars, 26 for unplaced)
    const int INF = INT_MAX / 2; // Use a large value to represent infinity, safe from overflow when adding distances.

    // Initialize dp table with INF
    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 27; ++j) {
            dp[i][j] = INF;
        }
    }

    // Base case: After typing the first character word[0].
    // One finger is at word[0]-'A', the other finger is unplaced (position 26).
    // The cost to reach this state is 0.
    dp[0][26] = 0; 

    // Iterate through the characters of the word, starting from the second character (index 1).
    for (int i = 1; i < n; ++i) {
        int curr_row = i % 2;
        int prev_row = (i - 1) % 2;

        // Reset the current row to INF before calculating new states for word[i].
        for (int j = 0; j < 27; ++j) {
            dp[curr_row][j] = INF;
        }

        int prev_char_pos = word[i-1] - 'A';      // Position of the character typed in the previous step (word[i-1]).
        int current_char_pos = word[i] - 'A';    // Position of the character to be typed in the current step (word[i]).

        // Iterate through all possible positions of the 'other' finger from the previous step.
        // 'other_finger_prev_pos' is the position of the finger that *did not* type word[i-1].
        for (int other_finger_prev_pos = 0; other_finger_prev_pos < 27; ++other_finger_prev_pos) {
            if (dp[prev_row][other_finger_prev_pos] == INF) {
                continue; // This previous state was unreachable, so skip it.
            }

            // Option 1: The finger that was at 'prev_char_pos' moves to type 'current_char_pos'.
            // The 'other' finger remains at 'other_finger_prev_pos'.
            // New state: one finger at 'current_char_pos', the other at 'other_finger_prev_pos'.
            // This state is valid only if the two fingers are on different characters.
            // 'other_finger_prev_pos' must not be equal to 'current_char_pos'.
            // If 'other_finger_prev_pos' is 26 (unplaced), it's not a character, so the condition holds.
            if (other_finger_prev_pos != current_char_pos) {
                int cost_to_move_prev_char_finger = get_dist(prev_char_pos, current_char_pos);
                dp[curr_row][other_finger_prev_pos] = MIN(dp[curr_row][other_finger_prev_pos],
                                                           dp[prev_row][other_finger_prev_pos] + cost_to_move_prev_char_finger);
            }

            // Option 2: The finger that was at 'other_finger_prev_pos' moves to type 'current_char_pos'.
            // The first finger remains at 'prev_char_pos'.
            // New state: one finger at 'current_char_pos', the other at 'prev_char_pos'.
            // This state is valid only if the two fingers are on different characters.
            // 'prev_char_pos' must not be equal to 'current_char_pos'.
            if (prev_char_pos != current_char_pos) {
                int cost_to_move_other_finger = 0;
                if (other_finger_prev_pos != 26) { // If the 'other' finger was placed, calculate its movement cost.
                    cost_to_move_other_finger = get_dist(other_finger_prev_pos, current_char_pos);
                }
                dp[curr_row][prev_char_pos] = MIN(dp[curr_row][prev_char_pos],
                                                  dp[prev_row][other_finger_prev_pos] + cost_to_move_other_finger);
            }
        }
    }

    // After processing all characters, the minimum distance is the minimum value
    // across all possible 'other' finger positions in the last computed row.
    int final_min_dist = INF;
    int last_row = (n - 1) % 2; // The row corresponding to the last character word[n-1].
    for (int j = 0; j < 27; ++j) {
        final_min_dist = MIN(final_min_dist, dp[last_row][j]);
    }

    return final_min_dist;
}