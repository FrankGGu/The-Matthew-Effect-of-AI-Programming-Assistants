#include <stdio.h>
#include <stdlib.h>

int removeBoxes(int* boxes, int boxesSize);
int dp(int* boxes, int start, int end, int k, int** memo);

int removeBoxes(int* boxes, int boxesSize) {
    int** memo = (int**)malloc(boxesSize * sizeof(int*));
    for (int i = 0; i < boxesSize; i++) {
        memo[i] = (int*)malloc(boxesSize * sizeof(int));
        for (int j = 0; j < boxesSize; j++) {
            memo[i][j] = -1;
        }
    }
    int result = dp(boxes, 0, boxesSize - 1, 0, memo);
    for (int i = 0; i < boxesSize; i++) {
        free(memo[i]);
    }
    free(memo);
    return result;
}

int dp(int* boxes, int start, int end, int k, int** memo) {
    if (start > end) return 0;
    if (memo[start][end] != -1) return memo[start][end];

    int res = dp(boxes, start + 1, end, 0, memo);
    int same = 1;
    for (int i = start + 1; i <= end; i++) {
        if (boxes[i] == boxes[start]) {
            same++;
            int temp = dp(boxes, start + 1, i - 1, 0, memo) + dp(boxes, i + 1, end, k + same, memo);
            res = (res > temp) ? res : temp;
        }
    }
    memo[start][end] = res;
    return res;
}