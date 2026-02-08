#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestAltitude(int* gain, int gainSize){
    int maxAltitude = 0;
    int currentAltitude = 0;
    for (int i = 0; i < gainSize; i++) {
        currentAltitude += gain[i];
        if (currentAltitude > maxAltitude) {
            maxAltitude = currentAltitude;
        }
    }
    return maxAltitude;
}