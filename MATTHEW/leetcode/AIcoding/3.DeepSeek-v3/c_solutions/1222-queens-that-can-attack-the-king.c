/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** queensAttacktheKing(int** queens, int queensSize, int* queensColSize, int* king, int kingSize, int* returnSize, int** returnColumnSizes) {
    int board[8][8] = {0};
    for (int i = 0; i < queensSize; i++) {
        board[queens[i][0]][queens[i][1]] = 1;
    }

    int** result = (int**)malloc(8 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(8 * sizeof(int));
    *returnSize = 0;

    int directions[8][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, 
                           {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};

    for (int d = 0; d < 8; d++) {
        int x = king[0] + directions[d][0];
        int y = king[1] + directions[d][1];

        while (x >= 0 && x < 8 && y >= 0 && y < 8) {
            if (board[x][y] == 1) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = x;
                result[*returnSize][1] = y;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
                break;
            }
            x += directions[d][0];
            y += directions[d][1];
        }
    }

    return result;
}