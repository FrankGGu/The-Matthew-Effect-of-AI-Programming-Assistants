#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maximizeWin(int* prizePositions, int prizePositionsSize, int k) {
    int max_win = 0;
    for (int i = 0; i < prizePositionsSize; i++) {
        int end1 = prizePositions[i] + k;
        int count1 = 0;
        for (int j = 0; j < prizePositionsSize; j++) {
            if (prizePositions[j] >= prizePositions[i] && prizePositions[j] <= end1) {
                count1++;
            }
        }

        int max_count2 = 0;
        for (int j = 0; j < prizePositionsSize; j++) {
            if (prizePositions[j] < prizePositions[i] || prizePositions[j] > end1) {
                int end2 = prizePositions[j] + k;
                int count2 = 0;
                for (int l = 0; l < prizePositionsSize; l++) {
                    if (prizePositions[l] >= prizePositions[j] && prizePositions[l] <= end2 && (prizePositions[l] < prizePositions[i] || prizePositions[l] > end1)) {
                        count2++;
                    }
                }
                max_count2 = max(max_count2, count2);
            }
        }
        max_win = max(max_win, count1 + max_count2);
    }
    return max_win;
}