#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfFullRounds(char* start, char* end) {
    int startHour = 0, startMin = 0;
    int endHour = 0, endMin = 0;

    sscanf(start, "%d:%d", &startHour, &startMin);
    sscanf(end, "%d:%d", &endHour, &endMin);

    int startTime = startHour * 60 + startMin;
    int endTime = endHour * 60 + endMin;

    if (startTime > endTime) {
        endTime += 24 * 60;
    }

    int fullRounds = 0;
    int firstRoundStart = ((startTime + 59) / 60) * 60;
    int lastRoundEnd = (endTime / 60) * 60;

    if (firstRoundStart <= endTime) {
        fullRounds = (lastRoundEnd - firstRoundStart) / 60;
    }

    return fullRounds;
}