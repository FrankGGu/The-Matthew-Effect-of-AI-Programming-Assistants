class Solution {
public:
    int findMinStep(string board, string hand) {
        vector<int> handCount(26, 0);
        for (char c : hand) handCount[c - 'A']++;
        return dfs(board, handCount);
    }

    int dfs(string board, vector<int>& handCount) {
        if (board.empty()) return 0;
        board = removeConsecutive(board);
        if (board.empty()) return 0;

        int result = INT_MAX;
        for (int i = 0; i < board.size(); i++) {
            for (int j = 1; j <= handCount[board[i] - 'A']; j++) {
                string newBoard = board;
                newBoard.insert(i, j, board[i]);
                newBoard = removeConsecutive(newBoard);
                handCount[board[i] - 'A'] -= j;
                int nextStep = dfs(newBoard, handCount);
                if (nextStep != -1) {
                    result = min(result, nextStep + j);
                }
                handCount[board[i] - 'A'] += j;
            }
        }
        return result == INT_MAX ? -1 : result;
    }

    string removeConsecutive(string board) {
        for (int i = 0; i < board.size();) {
            int count = 1;
            while (i + 1 < board.size() && board[i] == board[i + 1]) {
                count++;
                i++;
            }
            if (count >= 3) {
                board.erase(i - count + 1, count);
                i = max(0, i - count + 1);
            } else {
                i++;
            }
        }
        return board;
    }
};