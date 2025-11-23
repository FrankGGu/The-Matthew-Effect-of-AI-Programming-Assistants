#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int findMinDifference(char ** timePoints, int timePointsSize){
    int minutes[timePointsSize];
    for(int i = 0; i < timePointsSize; i++){
        int hour = (timePoints[i][0] - '0') * 10 + (timePoints[i][1] - '0');
        int minute = (timePoints[i][3] - '0') * 10 + (timePoints[i][4] - '0');
        minutes[i] = hour * 60 + minute;
    }

    qsort(minutes, timePointsSize, sizeof(int), cmpfunc);

    int minDiff = INT_MAX;
    for(int i = 1; i < timePointsSize; i++){
        int diff = minutes[i] - minutes[i - 1];
        if(diff < minDiff){
            minDiff = diff;
        }
    }

    int lastDiff = minutes[0] + 1440 - minutes[timePointsSize - 1];
    if(lastDiff < minDiff){
        minDiff = lastDiff;
    }

    return minDiff;
}