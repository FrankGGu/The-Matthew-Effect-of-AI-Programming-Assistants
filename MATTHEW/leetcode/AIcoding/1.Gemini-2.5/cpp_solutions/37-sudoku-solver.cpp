class Solution {
public:
    void solveSudoku(std::vector<std::vector<char>>& board) {
        solve(board);
    }

private:
    bool isValid(const std::vector<std::vector<char>>& board, int row, int col, char c) {
        // Check row
        for (int j = 0; j < 9; ++j) {
            if (board[row][j] == c) {
                return false;
            }
        }

        // Check column
        for (int i = 0; i < 9; ++i) {
            if (board[i][col] == c) {
                return false;
            }
        }

        // Check 3x3 box
        int startRow = (row / 3) * 3;
        int startCol = (col / 3) * 3;
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (board[startRow + i][startCol + j] == c) {
                    return false;
                }
            }
        }
        return true;
    }

    bool solve(std::vector<std::vector<char>>& board) {
        for (int i = 0; i < 9; ++i) {
            for (int j = 0; j < 9; ++j) {
                if (board[i][j] == '.') {
                    for (char c = '1'; c <= '9'; ++c) {
                        if (isValid(board, i, j, c)) {
                            board[i][j] = c;
                            if (solve(board)) {
                                return true;
                            } else {
                                board[i][j] = '.'; // Backtrack
                            }
                        }
                    }
                    return false; // No digit worked for this cell
                }
            }
        }
        return true; // All cells filled
    }
};