#include <stdio.h>
#include <stdlib.h>

int binaryGap(int n) {
    int maxDistance = 0;
    int lastPosition = -1;
    int position = 0;

    while (n > 0) {
        if (n & 1) {
            if (lastPosition != -1) {
                int distance = position - lastPosition;
                if (distance > maxDistance) {
                    maxDistance = distance;
                }
            }
            lastPosition = position;
        }
        n >>= 1;
        position++;
    }

    return maxDistance;
}