#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumPopulation(int** logs, int logsSize, int* logsColSize){
    int years[101] = {0};
    for (int i = 0; i < logsSize; i++) {
        for (int j = logs[i][0] - 1950; j < logs[i][1] - 1950; j++) {
            years[j]++;
        }
    }
    int maxPopulation = 0;
    int maxYear = 1950;
    for (int i = 0; i < 101; i++) {
        if (years[i] > maxPopulation) {
            maxPopulation = years[i];
            maxYear = 1950 + i;
        }
    }
    return maxYear;
}