#include <string.h>
#include <stdbool.h>

bool check(int r, int c, int dr, int dc, char** board, int m, int n, char* word, int word_len) {
    // 1. Check the cell immediately before the starting position (r, c).
    // It must be a '#' or out of bounds. If it's another character or ' ',
    // the word cannot start here.
    int prev_r = r - dr;
    int prev_c = c - dc;
    if (prev_r >= 0 && prev_r < m && prev_c >= 0 && prev_c < n && board[prev_r][prev_c] != '#') {
        return false;
    }

    // 2. Iterate through the word and check each character against the board.
    for (int i = 0; i < word_len; ++i) {
        int curr_r = r + i * dr;
        int curr_c = c + i * dc;

        // Check if current position is out of bounds.
        if (curr_r < 0 || curr_r >= m || curr_c < 0 || curr_c >= n) {
            return false; // Word goes out of bounds before fully placed
        }
        // Check if current position is a blocked cell ('#').
        if (board[curr_r][curr_c] == '#') {
            return false; // Blocked cell encountered
        }
        // Check for mismatch with an existing letter.
        // If board[curr_r][curr_c] is ' ', it matches any letter.
        if (board[curr_r][curr_c] != ' ' && board[curr_r][curr_c] != word[i]) {
            return false; // Mismatch with an existing letter
        }
    }

    // 3. Check the cell immediately after the ending position of the word.
    // It must be a '#' or out of bounds. If it's another character or ' ',
    // the word cannot end here.
    int next_r = r + word_len * dr;
    int next_c = c + word_len * dc;
    if (next_r >= 0 && next_r < m && next_c >= 0 && next_c < n && board[next_r][next_c] != '#') {
        return false;
    }

    // If all checks pass, the word can be placed.
    return true;
}

bool placeWordInCrossword(char** board, int boardSize, int* boardColSize, char* word) {
    int m = boardSize;
    int n = boardColSize[0]; // Assuming a rectangular board
    int word_len = strlen(word);

    // Define direction vectors for (right, left, down, up)
    int dr[] = {0, 0, 1, -1};
    int dc[] = {1, -1, 0, 0};

    // Iterate through every cell in the board as a potential starting point
    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            // For each cell, try placing the word in all four directions
            for (int i = 0; i < 4; ++i) {
                if (check(r, c, dr[i], dc[i], board, m, n, word, word_len)) {
                    return true; // Word can be placed
                }
            }
        }
    }

    return false; // Word cannot be placed anywhere on the board
}