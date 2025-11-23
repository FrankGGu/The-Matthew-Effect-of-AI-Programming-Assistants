#include <vector>
#include <iostream>

using namespace std;

class Solution {
public:
    int numRookCaptures(vector<vector<char>>& board) {
        int row, col;
        for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                if (board[i][j] == 'r') {
                    row = i;
                    col = j;
                    break;
                }
            }
        }

        int count = 0;

                for (int i = row - 1; i >= 0; --i) {
            if (board[i][col] == 'p') {
                count++;
                break;
            } else if (board[i][col] == 'B') {
                break;
            }
        }

                for (int i = row + 1; i < 8; ++i) {
            if (board[i][col] == 'p') {
                count++;
                break;
            } else if (board[i][col] == 'B') {
                break;
            }
        }

                for (int j = col - 1; j >= 0; --j) {
            if (board[row][j] == 'p') {
                count++;
                break;
            } else if (board[row][j] == 'B') {
                break;
            }
        }

                for (int j = col + 1; j < 8; ++j) {
            if (board[row][j] == 'p') {
                count++;
                break;
            } else if (board[row][j] == 'B') {
                break;
            }
        }

        return count;
    }
};