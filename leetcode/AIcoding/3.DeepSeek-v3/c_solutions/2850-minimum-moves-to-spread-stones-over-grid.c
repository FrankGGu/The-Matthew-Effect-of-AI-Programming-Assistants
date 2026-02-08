/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

int moves;

void backtrack(int** grid, int pos, int moveCount, int* zeros, int zeroCount) {
    if (pos == zeroCount) {
        if (moveCount < moves) {
            moves = moveCount;
        }
        return;
    }

    if (moveCount >= moves) {
        return;
    }

    int row = zeros[pos] / 3;
    int col = zeros[pos] % 3;

    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (grid[i][j] > 1) {
                grid[i][j]--;
                grid[row][col]++;
                int dist = abs(i - row) + abs(j - col);
                backtrack(grid, pos + 1, moveCount + dist, zeros, zeroCount);
                grid[row][col]--;
                grid[i][j]++;
            }
        }
    }
}

int minimumMoves(int** grid, int gridSize, int* gridColSize) {
    moves = INT_MAX;
    int zeros[9];
    int zeroCount = 0;

    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (grid[i][j] == 0) {
                zeros[zeroCount++] = i * 3 + j;
            }
        }
    }

    if (zeroCount == 0) {
        return 0;
    }

    backtrack(grid, 0, 0, zeros, zeroCount);
    return moves;
}