#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    bool check(int r, int c, int dr, int dc, const std::vector<std::vector<char>>& board, const std::string& word, int m, int n) {
        int len = word.length();

        int prev_r = r - dr;
        int prev_c = c - dc;
        if (prev_r >= 0 && prev_r < m && prev_c >= 0 && prev_c < n && board[prev_r][prev_c] != '#') {
            return false;
        }

        for (int k = 0; k < len; ++k) {
            int curr_r = r + k * dr;
            int curr_c = c + k * dc;

            if (curr_r < 0 || curr_r >= m || curr_c < 0 || curr_c >= n) {
                return false;
            }
            if (board[curr_r][curr_c] != ' ' && board[curr_r][curr_c] != word[k]) {
                return false;
            }
        }

        int next_r = r + len * dr;
        int next_c = c + len * dc;
        if (next_r >= 0 && next_r < m && next_c >= 0 && next_c < n && board[next_r][next_c] != '#') {
            return false;
        }

        return true;
    }

    bool placeWordInCrossword(std::vector<std::vector<char>>& board, std::string word) {
        int m = board.size();
        int n = board[0].size();

        std::string reversed_word = word;
        std::reverse(reversed_word.begin(), reversed_word.end());

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (check(r, c, 0, 1, board, word, m, n)) return true;
                if (check(r, c, 0, 1, board, reversed_word, m, n)) return true;

                if (check(r, c, 1, 0, board, word, m, n)) return true;
                if (check(r, c, 1, 0, board, reversed_word, m, n)) return true;
            }
        }

        return false;
    }
};