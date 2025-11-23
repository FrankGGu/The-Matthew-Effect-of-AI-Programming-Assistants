#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int movesToChessboard(vector<vector<int>>& board) {
        int n = board.size();
        int rowMask = 0, colMask = 0;
        for (int i = 0; i < n; ++i) {
            rowMask ^= board[0][i] << i;
            colMask ^= board[i][0] << i;
        }

        int rowCnt = 0, colCnt = 0;
        for (int i = 0; i < n; ++i) {
            int currRowMask = 0, currColMask = 0;
            for (int j = 0; j < n; ++j) {
                currRowMask ^= board[i][j] << j;
                currColMask ^= board[j][i] << j;
            }
            if (currRowMask != rowMask && currRowMask != (rowMask ^ ((1 << n) - 1))) return -1;
            if (currColMask != colMask && currColMask != (colMask ^ ((1 << n) - 1))) return -1;
            if (currRowMask == rowMask) rowCnt++;
            if (currColMask == colMask) colCnt++;
        }

        if (rowCnt != n / 2 && rowCnt != (n + 1) / 2) return -1;
        if (colCnt != n / 2 && colCnt != (n + 1) / 2) return -1;

        int rowMoves = 0, colMoves = 0;
        for (int i = 0; i < n; ++i) {
            if ((rowMask >> i & 1) != (i & 1)) rowMoves++;
            if ((colMask >> i & 1) != (i & 1)) colMoves++;
        }

        if (n % 2 == 0) {
            rowMoves = min(rowMoves, n - rowMoves);
            colMoves = min(colMoves, n - colMoves);
        } else {
            if (rowCnt == n / 2) rowMoves = n - rowMoves;
            if (colCnt == n / 2) colMoves = n - colMoves;
        }

        return (rowMoves + colMoves) / 2;
    }
};