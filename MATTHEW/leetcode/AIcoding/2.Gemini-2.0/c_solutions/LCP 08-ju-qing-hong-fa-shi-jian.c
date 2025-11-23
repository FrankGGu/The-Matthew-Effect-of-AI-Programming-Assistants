#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getTriggerTime(int** increase, int increaseSize, int* increaseColSize, int** requirements, int requirementsSize, int* requirementsColSize) {
    int* ans = (int*)malloc(sizeof(int) * requirementsSize);
    for (int i = 0; i < requirementsSize; i++) {
        ans[i] = -1;
    }

    int c = 0, r = 0, h = 0;
    for (int t = 0; t <= increaseSize; t++) {
        int current_c = (t == 0) ? 0 : c + increase[t - 1][0];
        int current_r = (t == 0) ? 0 : r + increase[t - 1][1];
        int current_h = (t == 0) ? 0 : h + increase[t - 1][2];

        for (int i = 0; i < requirementsSize; i++) {
            if (ans[i] == -1 && requirements[i][0] <= current_c && requirements[i][1] <= current_r && requirements[i][2] <= current_h) {
                ans[i] = t;
            }
        }

        c = current_c;
        r = current_r;
        h = current_h;
    }

    return ans;
}