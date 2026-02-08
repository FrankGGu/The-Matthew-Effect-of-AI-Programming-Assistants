class Solution {
public:
    int countBattleships(vector<vector<char>>& board) {
        int count = 0;
        int m = board.size();
        if (m == 0) return 0;
        int n = board[0].size();

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (board[i][j] == 'X') {
                    count++;
                    while (j < n && board[i][j] == 'X') j++;
                }
            }
        }

        return count;
    }
};