class Solution {
public:
    int findMinStep(string board, string hand) {
        unordered_map<char, int> handCount;
        for (char c : hand) {
            handCount[c]++;
        }
        int res = dfs(board, handCount);
        return res == INT_MAX ? -1 : res;
    }

    int dfs(string board, unordered_map<char, int>& handCount) {
        if (board.empty()) return 0;
        board = removeConsecutive(board);
        if (board.empty()) return 0;

        int minSteps = INT_MAX;
        for (int i = 0; i < board.size(); ++i) {
            for (char c : handCount) {
                if (handCount[c.first] > 0) {
                    int need = getNeed(board, i, c.first);
                    if (need > 0 && handCount[c.first] >= need) {
                        handCount[c.first] -= need;
                        string newBoard = createNewBoard(board, i, need);
                        int steps = dfs(newBoard, handCount);
                        if (steps != INT_MAX) {
                            minSteps = min(minSteps, steps + need);
                        }
                        handCount[c.first] += need;
                    }
                }
            }
        }
        return minSteps;
    }

    string removeConsecutive(string board) {
        for (int i = 0; i < board.size(); ) {
            int count = 1;
            while (i + count < board.size() && board[i] == board[i + count]) {
                count++;
            }
            if (count >= 3) {
                board.erase(i, count);
                i = max(0, i - 1);
            } else {
                i += count;
            }
        }
        return board;
    }

    int getNeed(const string& board, int index, char c) {
        int left = index, right = index;
        while (left >= 0 && board[left] == board[index]) --left;
        while (right < board.size() && board[right] == board[index]) ++right;
        return 3 - (right - left - 1);
    }

    string createNewBoard(const string& board, int index, int need) {
        string newBoard = board;
        char color = board[index];
        int left = index, right = index;
        while (left >= 0 && newBoard[left] == color) --left;
        while (right < newBoard.size() && newBoard[right] == color) ++right;
        newBoard.erase(left + 1, right - left - 1);
        newBoard.insert(left + 1, need, color);
        return removeConsecutive(newBoard);
    }
};