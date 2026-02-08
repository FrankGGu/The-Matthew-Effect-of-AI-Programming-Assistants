#include <stdio.h>
#include <stdlib.h>

int maxDistToClosest(int* seats, int seatsSize) {
    int maxDist = 0;
    int first = -1;
    int last = -1;
    int prev = -1;

    for (int i = 0; i < seatsSize; i++) {
        if (seats[i] == 1) {
            if (first == -1) {
                first = i;
            }
            if (prev != -1) {
                int dist = i - prev;
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
            prev = i;
            last = i;
        }
    }

    int leading = first;
    int trailing = seatsSize - 1 - last;

    if (leading > maxDist) {
        maxDist = leading;
    }
    if (trailing > maxDist) {
        maxDist = trailing;
    }

    return maxDist;
}