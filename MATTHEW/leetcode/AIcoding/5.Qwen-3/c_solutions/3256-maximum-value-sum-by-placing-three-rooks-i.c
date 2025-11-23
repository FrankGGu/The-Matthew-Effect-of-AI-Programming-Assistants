#include <stdio.h>
#include <stdlib.h>

int maximumValueSum(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int* rowMax = (int*)malloc(n * sizeof(int));
    int* colMax = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        rowMax[i] = board[i][0];
        for (int j = 1; j < n; j++) {
            if (board[i][j] > rowMax[i]) {
                rowMax[i] = board[i][j];
            }
        }
    }

    for (int j = 0; j < n; j++) {
        colMax[j] = board[0][j];
        for (int i = 1; i < n; i++) {
            if (board[i][j] > colMax[j]) {
                colMax[j] = board[i][j];
            }
        }
    }

    int maxSum = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int sum = rowMax[i] + colMax[j];
            if (i == j) {
                sum -= board[i][j];
            }
            if (sum > maxSum) {
                maxSum = sum;
            }
        }
    }

    free(rowMax);
    free(colMax);
    return maxSum;
}