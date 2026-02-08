#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int findMinStep(string board, string hand) {
        vector<int> h(5, 0);
        for (char c : hand) {
            h[getColorIndex(c)]++;
        }

        int ans = solve(board, h);
        return ans == INT_MAX ? -1 : ans;
    }

private:
    int getColorIndex(char c) {
        if (c == 'R') return 0;
        if (c == 'Y') return 1;
        if (c == 'B') return 2;
        if (c == 'G') return 3;
        return 4;
    }

    int solve(string board, vector<int>& hand) {
        if (board.empty()) return 0;

        int ans = INT_MAX;
        for (int i = 0; i < board.length(); ++i) {
            for (int j = 0; j < 5; ++j) {
                char color = getColorChar(j);
                if (board[i] == color && hand[j] > 0) {
                    int k = i + 1;
                    while (k < board.length() && board[k] == color) {
                        k++;
                    }
                    int count = k - i;
                    if (count + 1 >= 3) {
                        hand[j]--;
                        string newBoard = board.substr(0, i) + board.substr(k);
                        newBoard = cleanBoard(newBoard);
                        int next = solve(newBoard, hand);
                        if (next != INT_MAX) {
                            ans = min(ans, 1 + next);
                        }
                        hand[j]++;
                    }
                } else if (board[i] != color && hand[j] > 0) {
                    hand[j]--;
                    string newBoard = board.substr(0, i) + color + board.substr(i);
                    newBoard = cleanBoard(newBoard);
                    int next = solve(newBoard, hand);
                    if (next != INT_MAX) {
                        ans = min(ans, 1 + next);
                    }
                    hand[j]++;
                }
            }
        }

        return ans;
    }

    char getColorChar(int index) {
        if (index == 0) return 'R';
        if (index == 1) return 'Y';
        if (index == 2) return 'B';
        if (index == 3) return 'G';
        return 'W';
    }

    string cleanBoard(string board) {
        int i = 0;
        while (i < board.length()) {
            int j = i + 1;
            while (j < board.length() && board[j] == board[i]) {
                j++;
            }
            if (j - i >= 3) {
                board = board.substr(0, i) + board.substr(j);
                i = 0;
            } else {
                i++;
            }
        }
        return board;
    }
};