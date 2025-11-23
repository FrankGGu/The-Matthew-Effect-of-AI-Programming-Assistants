#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTimeToVisitAllPoints(int** points, int pointsSize, int* pointsColSize){
    int time = 0;
    for (int i = 0; i < pointsSize - 1; i++) {
        int x_diff = abs(points[i+1][0] - points[i][0]);
        int y_diff = abs(points[i+1][1] - points[i][1]);
        time += (x_diff > y_diff) ? x_diff : y_diff;
    }
    return time;
}