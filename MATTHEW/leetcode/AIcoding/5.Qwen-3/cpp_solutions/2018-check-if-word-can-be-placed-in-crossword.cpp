#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool placeWordInCrossword(vector<vector<char>>& board, string word) {
        int n = board.size();
        int m = board[0].size();
        int len = word.length();

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (board[i][j] == ' ' || board[i][j] == word[0]) {
                    if (checkHorizontal(board, word, i, j)) return true;
                    if (checkVertical(board, word, i, j)) return true;
                }
            }
        }
        return false;
    }

private:
    bool checkHorizontal(vector<vector<char>>& board, string& word, int row, int col) {
        int n = board.size();
        int m = board[0].size();
        int len = word.length();

        if (col + len > m) return false;

        bool valid = true;
        for (int i = 0; i < len; ++i) {
            if (board[row][col + i] != ' ' && board[row][col + i] != word[i]) {
                valid = false;
                break;
            }
        }

        if (valid) {
            if (col + len == m || board[row][col + len] == ' ') return true;
            if (col == 0 || board[row][col - 1] == ' ') return true;
        }

        return false;
    }

    bool checkVertical(vector<vector<char>>& board, string& word, int row, int col) {
        int n = board.size();
        int m = board[0].size();
        int len = word.length();

        if (row + len > n) return false;

        bool valid = true;
        for (int i = 0; i < len; ++i) {
            if (board[row + i][col] != ' ' && board[row + i][col] != word[i]) {
                valid = false;
                break;
            }
        }

        if (valid) {
            if (row + len == n || board[row + len][col] == ' ') return true;
            if (row == 0 || board[row - 1][col] == ' ') return true;
        }

        return false;
    }
};