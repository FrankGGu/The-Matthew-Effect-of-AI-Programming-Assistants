#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDistToClosest(int* seats, int seatsSize){
    int maxDist = 0;
    int last = -1;
    for (int i = 0; i < seatsSize; i++) {
        if (seats[i] == 1) {
            if (last == -1) {
                maxDist = i;
            } else {
                int dist = (i - last) / 2;
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
            last = i;
        }
    }
    if (seatsSize - 1 - last > maxDist) {
        maxDist = seatsSize - 1 - last;
    }
    return maxDist;
}