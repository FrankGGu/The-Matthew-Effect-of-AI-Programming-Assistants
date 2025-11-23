#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDaysWithoutMeetings(int meetings[][2], int meetingsSize, int meetingsColSize, int workHours) {
    int totalMeetingsHours = 0;
    for (int i = 0; i < meetingsSize; i++) {
        totalMeetingsHours += meetings[i][1] - meetings[i][0];
    }
    return (workHours > totalMeetingsHours) ? workHours - totalMeetingsHours : 0;
}