#include <stdlib.h>

int compareMeetings(const void* a, const void* b) {
    const int* meetingA = *(const int**)a;
    const int* meetingB = *(const int**)b;

    if (meetingA[0] != meetingB[0]) {
        return meetingA[0] - meetingB[0];
    }
    return meetingA[1] - meetingB[1];
}

int max(int a, int b) {
    return a > b ? a : b;
}

int rescheduleMeetingsForMaximumFreeTime(int** meetings, int meetingsSize, int* meetingsColSize) {
    if (meetingsSize <= 1) {
        return 0;
    }

    qsort(meetings, meetingsSize, sizeof(int*), compareMeetings);

    int** mergedMeetings = (int**)malloc(meetingsSize * sizeof(int*));
    for (int i = 0; i < meetingsSize; ++i) {
        mergedMeetings[i] = (int*)malloc(2 * sizeof(int));
    }
    int mergedMeetingsSize = 0;

    mergedMeetings[mergedMeetingsSize][0] = meetings[0][0];
    mergedMeetings[mergedMeetingsSize][1] = meetings[0][1];
    mergedMeetingsSize++;

    for (int i = 1; i < meetingsSize; ++i) {
        int* currentMerged = mergedMeetings[mergedMeetingsSize - 1];
        int* nextMeeting = meetings[i];

        if (nextMeeting[0] <= currentMerged[1]) {
            currentMerged[1] = max(currentMerged[1], nextMeeting[1]);
        } else {
            mergedMeetings[mergedMeetingsSize][0] = nextMeeting[0];
            mergedMeetings[mergedMeetingsSize][1] = nextMeeting[1];
            mergedMeetingsSize++;
        }
    }

    int maxFreeTime = 0;
    for (int i = 0; i < mergedMeetingsSize - 1; ++i) {
        int gap = mergedMeetings[i+1][0] - mergedMeetings[i][1];
        maxFreeTime = max(maxFreeTime, gap);
    }

    for (int i = 0; i < meetingsSize; ++i) {
        free(mergedMeetings[i]);
    }
    free(mergedMeetings);

    return maxFreeTime;
}