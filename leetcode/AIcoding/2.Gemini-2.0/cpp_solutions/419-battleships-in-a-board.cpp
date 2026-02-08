class Solution {
public:
    int countBattleships(vector<vector<char>>& board) {
        int count = 0;
        int rows = board.size();
        int cols = board[0].size();

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (board[i][j] == 'X') {
                    if ((i > 0 && board[i - 1][j] == 'X') || (j > 0 && board[i][j - 1] == 'X')) {
                        continue;
                    }
                    count++;
                }
            }
        }

        return count;
    }
};