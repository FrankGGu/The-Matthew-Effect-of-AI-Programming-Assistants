class Solution {
public:
    int findMinStep(string board, string hand) {
        unordered_map<char, int> handCount;
        for (char c : hand) handCount[c]++;
        int res = backtrack(board, handCount);
        return res == INT_MAX ? -1 : res;
    }

private:
    int backtrack(string board, unordered_map<char, int>& handCount) {
        if (board.empty()) return 0;
        int res = INT_MAX;
        int i = 0;
        while (i < board.size()) {
            int j = i;
            while (j < board.size() && board[j] == board[i]) j++;
            char color = board[i];
            int needed = 3 - (j - i);
            if (handCount[color] >= needed) {
                string newBoard = updateBoard(board.substr(0, i) + board.substr(j));
                handCount[color] -= needed;
                int next = backtrack(newBoard, handCount);
                if (next != INT_MAX) res = min(res, next + needed);
                handCount[color] += needed;
            }
            i = j;
        }
        return res;
    }

    string updateBoard(string board) {
        int i = 0;
        while (i < board.size()) {
            int j = i;
            while (j < board.size() && board[j] == board[i]) j++;
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