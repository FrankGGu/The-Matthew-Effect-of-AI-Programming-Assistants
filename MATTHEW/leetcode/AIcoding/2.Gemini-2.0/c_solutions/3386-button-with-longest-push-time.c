#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longest_push_time(int* releaseTimes, int releaseTimesSize, char* pressedKeys, int pressedKeysSize) {
    int max_duration = releaseTimes[0];
    for (int i = 1; i < releaseTimesSize; i++) {
        int duration = releaseTimes[i] - releaseTimes[i - 1];
        if (duration > max_duration) {
            max_duration = duration;
        }
    }
    return max_duration;
}