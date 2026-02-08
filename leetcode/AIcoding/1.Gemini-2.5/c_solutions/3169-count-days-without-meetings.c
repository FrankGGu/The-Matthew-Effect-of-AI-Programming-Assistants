#include <stdlib.h>

int compareMeetings(const void* a, const void* b) {
    const int* meetingA = *(const int**)a;
    const int* meetingB = *(const int**)b;

    if (meetingA[0] != meetingB[0]) {
        return meetingA[0] - meetingB[0];
    }
    return meetingA[1] - meetingB[1];
}

int countDays(int days, int** meetings, int meetingsSize, int* meetingsColSize) {
    if (meetingsSize == 0) {
        return days;
    }

    qsort(meetings, meetingsSize, sizeof(int*), compareMeetings);

    long long totalMeetingDays = 0;

    int currentStart = meetings[0][0];
    int currentEnd = meetings[0][1];

    for (int i = 1; i < meetingsSize; i++) {
        int nextStart = meetings[i][0];
        int nextEnd = meetings[i][1];

        if (nextStart <= currentEnd + 1) {
            if (nextEnd > currentEnd) {
                currentEnd = nextEnd;
            }
        } else {
            totalMeetingDays += (long long)(currentEnd - currentStart + 1);
            currentStart = nextStart;
            currentEnd = nextEnd;
        }
    }

    totalMeetingDays += (long long)(currentEnd - currentStart + 1);

    return (int)(days - totalMeetingDays);
}