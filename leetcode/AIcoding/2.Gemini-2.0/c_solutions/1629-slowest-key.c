#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char slowestKey(int* releaseTimes, int releaseTimesSize, char* keysPressed) {
    char slowestKey = keysPressed[0];
    int longestDuration = releaseTimes[0];

    for (int i = 1; i < releaseTimesSize; i++) {
        int duration = releaseTimes[i] - releaseTimes[i - 1];
        if (duration > longestDuration) {
            longestDuration = duration;
            slowestKey = keysPressed[i];
        } else if (duration == longestDuration && keysPressed[i] > slowestKey) {
            slowestKey = keysPressed[i];
        }
    }

    return slowestKey;
}