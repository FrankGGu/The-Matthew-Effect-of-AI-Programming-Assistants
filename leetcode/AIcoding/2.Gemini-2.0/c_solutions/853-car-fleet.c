#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int carFleet(int target, int position[], int speed[], int positionSize){
    if (positionSize == 0) return 0;

    double *times = (double*)malloc(sizeof(double) * positionSize);
    int *indices = (int*)malloc(sizeof(int) * positionSize);

    for (int i = 0; i < positionSize; i++) {
        times[i] = (double)(target - position[i]) / speed[i];
        indices[i] = i;
    }

    // Sort indices based on position
    for (int i = 0; i < positionSize; i++) {
        for (int j = i + 1; j < positionSize; j++) {
            if (position[indices[i]] > position[indices[j]]) {
                int temp = indices[i];
                indices[i] = indices[j];
                indices[j] = temp;
            }
        }
    }

    int fleets = 1;
    double currentTime = times[indices[positionSize - 1]];

    for (int i = positionSize - 2; i >= 0; i--) {
        if (times[indices[i]] > currentTime) {
            fleets++;
            currentTime = times[indices[i]];
        }
    }

    free(times);
    free(indices);

    return fleets;
}