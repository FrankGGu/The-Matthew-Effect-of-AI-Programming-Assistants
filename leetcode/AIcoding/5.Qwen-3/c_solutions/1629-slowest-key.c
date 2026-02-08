#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* slowestKey(int* releaseTimes, int releaseTimesSize, char* s) {
    int maxDuration = releaseTimes[0];
    char result = s[0];

    for (int i = 1; i < releaseTimesSize; i++) {
        int duration = releaseTimes[i] - releaseTimes[i - 1];
        if (duration > maxDuration || (duration == maxDuration && s[i] > result)) {
            maxDuration = duration;
            result = s[i];
        }
    }

    char* output = (char*)malloc(2 * sizeof(char));
    output[0] = result;
    output[1] = '\0';
    return output;
}