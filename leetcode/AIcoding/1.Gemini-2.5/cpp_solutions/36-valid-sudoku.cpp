#include <vector>
#include <string>

class Solution {
public:
    bool isValidSudoku(std::vector<std::vector<char>>& board) {
        bool rows[9][9] = {false};
        bool cols[9][9] = {false};
        bool boxes[3][3][9] = {false};

        for (int i = 0; i < 9; ++i) {
            for (int j = 0; j < 9; ++j) {
                if (board[i][j] != '.') {
                    int num = board[i][j] - '1'; // Convert char digit to 0-8 index

                    // Check row
                    if (rows[i][num]) {
                        return false;
                    }
                    rows[i][num] = true;

                    // Check column
                    if (cols[j][num]) {
                        return false;
                    }
                    cols[j][num] = true;

                    // Check 3x3 box
                    int box_row = i / 3;
                    int box_col = j / 3;
                    if (boxes[box_row][box_col][num]) {
                        return false;
                    }
                    boxes[box_row][box_col][num] = true;
                }
            }
        }

        return true;
    }
};