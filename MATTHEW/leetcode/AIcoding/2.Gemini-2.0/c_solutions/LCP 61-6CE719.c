#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int temperatureTrend(int* temperatureA, int temperatureASize, int* temperatureB, int temperatureBSize) {
    int maxLen = 0;
    int currentLen = 0;
    for (int i = 0; i < temperatureASize - 1 && i < temperatureBSize - 1; i++) {
        int trendA = 0;
        int trendB = 0;

        if (temperatureA[i + 1] > temperatureA[i]) {
            trendA = 1;
        } else if (temperatureA[i + 1] < temperatureA[i]) {
            trendA = -1;
        } else {
            trendA = 0;
        }

        if (temperatureB[i + 1] > temperatureB[i]) {
            trendB = 1;
        } else if (temperatureB[i + 1] < temperatureB[i]) {
            trendB = -1;
        } else {
            trendB = 0;
        }

        if (trendA == trendB) {
            currentLen++;
        } else {
            maxLen = (currentLen > maxLen) ? currentLen : maxLen;
            currentLen = 0;
        }
    }
    maxLen = (currentLen > maxLen) ? currentLen : maxLen;
    return maxLen;
}