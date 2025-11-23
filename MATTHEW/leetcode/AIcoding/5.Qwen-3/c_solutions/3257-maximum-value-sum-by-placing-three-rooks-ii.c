#include <stdio.h>
#include <stdlib.h>

long long maximumValueSum(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    long long sum = 0;
    int count = 0;
    int minAbs = INT_MAX;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int val = board[i][j];
            if (val > 0) {
                sum += val;
                count++;
            } else {
                minAbs = (abs(val) < minAbs) ? abs(val) : minAbs;
            }
        }
    }

    if (count % 2 == 0) {
        return sum;
    } else {
        return sum - minAbs;
    }
}