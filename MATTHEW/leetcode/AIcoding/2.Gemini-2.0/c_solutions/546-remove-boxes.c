#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int removeBoxes(int* boxes, int boxesSize) {
    int dp[100][100][100];
    memset(dp, 0, sizeof(dp));

    int solve(int l, int r, int k) {
        if (l > r) return 0;
        if (dp[l][r][k] != 0) return dp[l][r][k];

        int i;
        int res = solve(l, r - 1, 0) + (boxes[r] + k) * (boxes[r] + k);
        for (i = l; i < r; i++) {
            if (boxes[i] == boxes[r]) {
                int temp = solve(l, i, boxes[r] + k) + solve(i + 1, r - 1, 0);
                if (temp > res) res = temp;
            }
        }
        dp[l][r][k] = res;
        return res;
    }

    int new_boxes[100];
    int new_boxesSize = 0;
    int count = 1;
    for (int i = 1; i < boxesSize; i++) {
        if (boxes[i] == boxes[i - 1]) {
            count++;
        } else {
            new_boxes[new_boxesSize++] = count;
            new_boxes[new_boxesSize++] = boxes[i - 1];
            count = 1;
        }
    }
    new_boxes[new_boxesSize++] = count;
    new_boxes[new_boxesSize++] = boxes[boxesSize - 1];

    int boxes_temp[100];
    int boxes_tempSize = 0;
    for(int i = 1; i < new_boxesSize; i += 2){
        for(int j = 0; j < new_boxes[i-1]; j++){
            boxes_temp[boxes_tempSize++] = new_boxes[i];
        }
    }

    return solve(0, boxes_tempSize - 1, 0);
}