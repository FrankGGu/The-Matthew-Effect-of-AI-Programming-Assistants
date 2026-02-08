#include <stdlib.h> // For malloc
#include <string.h> // Not strictly needed for this implementation but common for string problems

void append_moves(char *result, int *idx, char move_char, int count) {
    for (int i = 0; i < count; ++i) {
        result[(*idx)++] = move_char;
    }
}

char * alphabetBoardPath(char * target){
    // Maximum path length:
    // A target string has at most 100 characters.
    // Each character can require up to 5 'U/D' moves (e.g., from 'z' to 'a')
    // and up to 4 'L/R' moves (e.g., from 'a' to 'e'), plus 1 '!' character.
    // So, max 5 + 4 + 1 = 10 moves per target character.
    // Total max length = 100 * 10 + 1 (for null terminator) = 1001 bytes.
    char *result = (char *)malloc(sizeof(char) * 1001);
    if (!result) {
        return NULL; // Handle memory allocation failure
    }
    int res_idx = 0; // Current index in the result string

    // Starting position is 'a' (0,0)
    int current_row = 0;
    int current_col = 0;

    for (int i = 0; target[i] != '\0'; ++i) {
        char target_char = target[i];

        // Calculate target character's coordinates
        // 'a' through 'y' follow a simple grid pattern
        // 'z' is at (5,0)
        int target_row = (target_char - 'a') / 5;
        int target_col = (target_char - 'a') % 5;

        // The above calculation correctly places 'z' at (5,0) as 'z'-'a' = 25, so 25/5=5, 25%5=0.

        int dr = target_row - current_row; // Row difference
        int dc = target_col - current_col; // Column difference

        // Movement order strategy:
        // 1. If moving TO 'z', prioritize vertical moves (U/D) then horizontal (L/R).
        //    This ensures we reach row 5 before attempting horizontal moves, as (5,1) to (5,4) are invalid.
        // 2. If moving FROM 'z', prioritize vertical moves (U/D) then horizontal (L/R).
        //    This ensures we move off row 5 before attempting horizontal moves, as (5,1) to (5,4) are invalid.
        // 3. For all other cases (neither current nor target is 'z' in a critical way),
        //    prioritize horizontal moves (L/R) then vertical (U/D). This is generally safe.

        if (target_char == 'z') {
            // Moving TO 'z': Vertical moves first
            if (dr < 0) { // Move Up
                append_moves(result, &res_idx, 'U', -dr);
            } else if (dr > 0) { // Move Down
                append_moves(result, &res_idx, 'D', dr);
            }
            // Then Horizontal moves
            if (dc < 0) { // Move Left
                append_moves(result, &res_idx, 'L', -dc);
            } else if (dc > 0) { // Move Right
                append_moves(result, &res_idx, 'R', dc);
            }
        } else if (current_row == 5 && current_col == 0) { // Moving FROM 'z'
            // Must move Up first to get off row 5 (target_row will be < 5)
            if (dr < 0) { // Move Up
                append_moves(result, &res_idx, 'U', -dr);
            }
            // Then Horizontal moves
            if (dc < 0) { // Move Left
                append_moves(result, &res_idx, 'L', -dc);
            } else if (dc > 0) { // Move Right
                append_moves(result, &res_idx, 'R', dc);
            }
        } else { // General case: neither current nor target is 'z' in a critical way
            // Prioritize Horizontal moves
            if (dc < 0) { // Move Left
                append_moves(result, &res_idx, 'L', -dc);
            } else if (dc > 0) { // Move Right
                append_moves(result, &res_idx, 'R', dc);
            }
            // Then Vertical moves
            if (dr < 0) { // Move Up
                append_moves(result, &res_idx, 'U', -dr);
            } else if (dr > 0) { // Move Down
                append_moves(result, &res_idx, 'D', dr);
            }
        }

        result[res_idx++] = '!'; // Append '!' to select the character

        // Update current position to the target position for the next iteration
        current_row = target_row;
        current_col = target_col;
    }

    result[res_idx] = '\0'; // Null-terminate the result string
    return result;
}