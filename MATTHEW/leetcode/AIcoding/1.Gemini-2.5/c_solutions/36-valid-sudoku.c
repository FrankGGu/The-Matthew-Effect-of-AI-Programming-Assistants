#include <stdbool.h>
#include <string.h>

bool isValidSudoku(char** board, int boardSize, int* boardColSize) {
    bool row_seen[9][9]; // row_seen[i][j] is true if digit j+1 is seen in row i
    bool col_seen[9][9]; // col_seen[i][j] is true if digit j+1 is seen in col i
    bool box_seen[9][9]; // box_seen[i][j] is true if digit j+1 is seen in box i

    memset(row_seen, 0, sizeof(row_seen));
    memset(col_seen, 0, sizeof(col_seen));
    memset(box_seen, 0, sizeof(box_seen));

    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            char current_char = board[r][c];

            if (current_char == '.') {
                continue;
            }

            int num = current_char - '1'; 

            int box_index = (r / 3) * 3 + (c / 3);

            if (row_seen[r][num] || col_seen[c][num] || box_seen[box_index][num]) {
                return false;
            }

            row_seen[r][num] = true;
            col_seen[c][num] = true;
            box_seen[box_index][num] = true;
        }
    }

    return true;
}