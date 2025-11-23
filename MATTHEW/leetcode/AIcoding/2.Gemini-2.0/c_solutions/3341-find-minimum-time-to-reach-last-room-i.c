#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTimeToVisitLastRoom(int* dist, int distSize) {
    long long time = 0;
    long long farthest = 0;
    for (int i = 0; i < distSize; i++) {
        if (time > farthest) {
            time++;
        }
        time += dist[i];
        farthest = time;
    }
    return (int)time;
}