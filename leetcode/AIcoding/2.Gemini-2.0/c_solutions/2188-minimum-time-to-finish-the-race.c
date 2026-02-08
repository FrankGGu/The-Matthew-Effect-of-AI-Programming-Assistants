#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumFinishTime(int tire[][2], int tireSize, int changeTime, int numLaps) {
    int minTime[numLaps + 1];
    for (int i = 0; i <= numLaps; i++) {
        minTime[i] = INT_MAX;
    }
    minTime[0] = 0;

    for (int i = 0; i < tireSize; i++) {
        int f = tire[i][0];
        int r = tire[i][1];
        long long curTime = 0;
        long long totalTime = 0;
        for (int j = 1; j <= numLaps; j++) {
            curTime = (long long)f * pow(r, j - 1);
            totalTime += curTime;
            if (totalTime > 1e9) break;
            if (totalTime > INT_MAX) break;
            if (totalTime >= minTime[j]) continue;
            minTime[j] = totalTime;
        }
    }

    for (int i = 1; i <= numLaps; i++) {
        for (int j = 1; j < i; j++) {
            if (minTime[j] == INT_MAX || minTime[i - j] == INT_MAX) continue;
            if ((long long)minTime[j] + (long long)minTime[i - j] + changeTime < minTime[i]) {
                minTime[i] = minTime[j] + minTime[i - j] + changeTime;
            }
        }
    }

    return minTime[numLaps];
}