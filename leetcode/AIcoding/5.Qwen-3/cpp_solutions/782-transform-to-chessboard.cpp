#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int movesToChessboard(vector<vector<int>>& board) {
        int n = board.size();
        int rowSum = 0, colSum = 0;
        for (int i = 0; i < n; ++i) {
            rowSum += board[0][i];
            colSum += board[i][0];
        }
        if (rowSum != n / 2 && rowSum != (n + 1) / 2) return -1;
        if (colSum != n / 2 && colSum != (n + 1) / 2) return -1;

        int rowDiff = 0, colDiff = 0;
        for (int i = 0; i < n; ++i) {
            if (board[0][i] != (i % 2 == 0 ? 0 : 1)) rowDiff++;
            if (board[i][0] != (i % 2 == 0 ? 0 : 1)) colDiff++;
        }
        if (n % 2 == 0) {
            if (rowDiff % 2 != 0) return -1;
            if (colDiff % 2 != 0) return -1;
            return rowDiff / 2 + colDiff / 2;
        } else {
            if (rowDiff % 2 != 0) return -1;
            if (colDiff % 2 != 0) return -1;
            return rowDiff / 2 + colDiff / 2;
        }
    }
};