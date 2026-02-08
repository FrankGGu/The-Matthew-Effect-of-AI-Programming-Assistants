#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isSelfCrossing(int* distance, int distanceSize) {
    if (distanceSize < 4) {
        return false;
    }

    for (int i = 3; i < distanceSize; i++) {
        if (distance[i] >= distance[i - 2] && distance[i - 1] <= distance[i - 3]) {
            return true;
        }

        if (i >= 4 && distance[i - 1] == distance[i - 3] && distance[i] + distance[i - 4] >= distance[i - 2]) {
            return true;
        }

        if (i >= 5 && distance[i] + distance[i - 4] >= distance[i - 2] && distance[i - 1] + distance[i - 5] >= distance[i - 3] && distance[i - 1] <= distance[i - 3] && distance[i] <= distance[i - 2]) {
            return true;
        }
    }

    return false;
}