int[][] flipChess(char** chess, int chessSize, int* chessColSize){
    int directions[2][2] = {{1, 0}, {0, 1}};
    int maxFlips = 0;
    int bestRow = -1, bestCol = -1;
    int flips[6][6] = {0};

    for (int i = 0; i < chessSize; i++) {
        for (int j = 0; j < *chessColSize; j++) {
            if (chess[i][j] == '.') {
                int count = 0;
                for (int d = 0; d < 2; d++) {
                    int x = i + directions[d][0];
                    int y = j + directions[d][1];
                    while (x >= 0 && x < chessSize && y >= 0 && y < *chessColSize && chess[x][y] == 'W') {
                        count++;
                        x += directions[d][0];
                        y += directions[d][1];
                    }
                    if (x >= 0 && x < chessSize && y >= 0 && y < *chessColSize && chess[x][y] == 'B') {
                        count++;
                    }
                }
                if (count > maxFlips) {
                    maxFlips = count;
                    bestRow = i;
                    bestCol = j;
                }
            }
        }
    }

    if (bestRow != -1 && bestCol != -1) {
        for (int d = 0; d < 2; d++) {
            int x = bestRow + directions[d][0];
            int y = bestCol + directions[d][1];
            while (x >= 0 && x < chessSize && y >= 0 && y < *chessColSize && chess[x][y] == 'W') {
                flips[x][y] = 1;
                x += directions[d][0];
                y += directions[d][1];
            }
            if (x >= 0 && x < chessSize && y >= 0 && y < *chessColSize && chess[x][y] == 'B') {
                flips[x][y] = 1;
            }
        }
    }

    int** result = (int**)malloc(2 * sizeof(int*));
    result[0] = (int*)malloc(2 * sizeof(int));
    result[1] = (int*)malloc(2 * sizeof(int));
    result[0][0] = bestRow;
    result[0][1] = bestCol;
    result[1][0] = maxFlips;

    return result;
}