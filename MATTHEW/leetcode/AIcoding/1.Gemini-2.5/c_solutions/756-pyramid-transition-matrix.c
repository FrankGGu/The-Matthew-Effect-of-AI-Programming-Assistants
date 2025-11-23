#include <stdbool.h>
#include <string.h>

bool solve(char* current_level,
           char allowed_tops[7][7][7], int allowed_tops_count[7][7]);

bool dfs(char* current_level, int current_len, char* next_level_buffer, int next_level_idx,
         char allowed_tops[7][7][7], int allowed_tops_count[7][7]) {
    // Base case for building the next level: If we have filled all positions for the next level
    if (next_level_idx == current_len - 1) {
        next_level_buffer[next_level_idx] = '\0'; // Null-terminate the newly formed level string
        // Now, try to build the rest of the pyramid from this new level
        return solve(next_level_buffer, allowed_tops, allowed_tops_count);
    }

    // Determine the two characters from the current level that form the base for the current position
    char c1 = current_level[next_level_idx];
    char c2 = current_level[next_level_idx + 1];

    // Get the count of possible top characters for this pair
    int count = allowed_tops_count[c1 - 'A'][c2 - 'A'];

    // Iterate through all possible top characters for this pair
    for (int i = 0; i < count; i++) {
        char top = allowed_tops[c1 - 'A'][c2 - 'A'][i];
        next_level_buffer[next_level_idx] = top; // Place the character in the next level buffer

        // Recursively try to fill the next position in the next_level_buffer
        if (dfs(current_level, current_len, next_level_buffer, next_level_idx + 1,
                allowed_tops, allowed_tops_count)) {
            return true; // If a valid pyramid can be formed from this choice, return true
        }
    }

    return false; // No character works for the current position, backtrack
}

bool solve(char* current_level,
           char allowed_tops[7][7][7], int allowed_tops_count[7][7]) {
    int current_len = strlen(current_level);

    // Base case for the pyramid: If the current level has only one character, we successfully built the pyramid
    if (current_len == 1) {
        return true;
    }

    // The next level will have one less character.
    // Allocate a buffer for the next level string, including space for null terminator.
    // Max bottom length is 8, so max current_len is 8. next_level_buffer size 8 is sufficient.
    char next_level_buffer[current_len]; 

    // Start the depth-first search to build the next level string
    return dfs(current_level, current_len, next_level_buffer, 0,
               allowed_tops, allowed_tops_count);
}

bool pyramidTransition(char* bottom, char** allowed, int allowedSize) {
    // These arrays will store the allowed transitions in a more accessible format.
    // 'A' through 'G' correspond to indices 0 through 6.
    // allowed_tops[c1_idx][c2_idx] will store an array of possible top characters.
    char allowed_tops[7][7][7]; 
    // allowed_tops_count[c1_idx][c2_idx] will store the number of possible top characters for that pair.
    int allowed_tops_count[7][7]; 

    // Initialize all counts to 0
    for (int i = 0; i < 7; i++) {
        for (int j = 0; j < 7; j++) {
            allowed_tops_count[i][j] = 0;
        }
    }

    // Populate the allowed_tops and allowed_tops_count arrays from the input 'allowed' list
    for (int i = 0; i < allowedSize; i++) {
        char c1 = allowed[i][0];
        char c2 = allowed[i][1];
        char top = allowed[i][2];

        int idx1 = c1 - 'A';
        int idx2 = c2 - 'A';

        // Add the 'top' character to the list of possibilities for the (c1, c2) pair
        allowed_tops[idx1][idx2][allowed_tops_count[idx1][idx2]++] = top;
    }

    // Start the main recursive process from the 'bottom' level
    return solve(bottom, allowed_tops, allowed_tops_count);
}