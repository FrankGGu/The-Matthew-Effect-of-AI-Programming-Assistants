#include <stdlib.h>
#include <stdbool.h>

int** queensAttacktheKing(int** queens, int queensSize, int* queensColSize, int* king, int* returnSize, int** returnColumnSizes) {
    bool board[8][8] = {false};
    for (int i = 0; i < queensSize; i++) {
        board[queens[i][0]][queens[i][1]] = true;
    }

    int dx[] = {-1, -1, -1, 0, 0, 1, 1, 1};
    int dy[] = {-1, 0, 1, -1, 1, -1, 0, 1};

    int attackingQueens[8][2];
    int count = 0;

    for (int i = 0; i < 8; i++) {
        int r = king[0];
        int c = king[1];

        while (true) {
            r += dx[i];
            c += dy[i];

            if (r < 0 || r >= 8 || c < 0 || c >= 8) {
                break;
            }

            if (board[r][c]) {
                attackingQueens[count][0] = r;
                attackingQueens[count][1] = c;
                count++;
                break;
            }
        }
    }

    int** result = (int**) malloc(count * sizeof(int*));
    *returnColumnSizes = (int*) malloc(count * sizeof(int));
    *returnSize = count;

    for (int i = 0; i < count; i++) {
        result[i] = (int*) malloc(2 * sizeof(int));
        result[i][0] = attackingQueens[i][0];
        result[i][1] = attackingQueens[i][1];
        (*returnColumnSizes)[i] = 2;
    }

    return result;
}