class Solution {
public:
    int movesToChessboard(vector<vector<int>>& board) {
        int n = board.size();
        int rowSum = 0, colSum = 0, rowSwap = 0, colSwap = 0;

        for (int i = 0; i < n; ++i) {
            rowSum += board[0][i];
            colSum += board[i][0];
            if (board[i][0] == board[i ^ 1][0]) return -1;
            if (i > 0) {
                if (board[i][0] == board[i - 1][0]) rowSwap++;
                if (board[0][i] == board[0][i - 1]) colSwap++;
            }
        }

        if (rowSum != n / 2 && rowSum != (n + 1) / 2) return -1;
        if (colSum != n / 2 && colSum != (n + 1) / 2) return -1;

        if (n % 2 == 0) {
            return (rowSwap % 2 == 0 ? rowSwap : n - rowSwap) / 2 + 
                   (colSwap % 2 == 0 ? colSwap : n - colSwap) / 2;
        } else {
            return (rowSwap + 1) / 2 + (colSwap + 1) / 2;
        }
    }
};