int maxMoves(char** grid, int gridSize, int* gridColSize) {
    int moves = 0;
    int n = gridSize, m = *gridColSize;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 'P') {
                int newI = i, newJ = j;
                while (newI < n && newJ < m) {
                    if (grid[newI][newJ] == 'X') break;
                    newI++;
                    newJ++;
                    moves++;
                }
                newI = i; newJ = j;
                while (newI < n && newJ >= 0) {
                    if (grid[newI][newJ] == 'X') break;
                    newI++;
                    newJ--;
                    moves++;
                }
                newI = i; newJ = j;
                while (newI >= 0 && newJ < m) {
                    if (grid[newI][newJ] == 'X') break;
                    newI--;
                    newJ++;
                    moves++;
                }
                newI = i; newJ = j;
                while (newI >= 0 && newJ >= 0) {
                    if (grid[newI][newJ] == 'X') break;
                    newI--;
                    newJ--;
                    moves++;
                }
            }
        }
    }

    return moves;
}