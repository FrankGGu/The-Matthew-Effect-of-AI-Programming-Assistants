#include <stdlib.h> // For malloc, realloc, qsort
#include <string.h> // For memcpy (if needed)

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

int rescheduleMeetingsForMaximumFreeTimeII(int** meetings, int meetingsSize, int* meetingsColSize) {
    if (meetingsSize <= 1) {
        return 0;
    }

    qsort(meetings, meetingsSize, sizeof(int*), compareMeetings);

    int** mergedIntervals = (int**)malloc(meetingsSize * sizeof(int*));
    if (mergedIntervals == NULL) {
        return 0;
    }

    int mergedCount = 0;

    mergedIntervals[mergedCount] = (int*)malloc(2 * sizeof(int));
    if (mergedIntervals[mergedCount] == NULL) {
        free(mergedIntervals);
        return 0;
    }
    mergedIntervals[mergedCount][0] = meetings[0][0];
    mergedIntervals[mergedCount][1] = meetings[0][1];
    mergedCount++;

    for (int i = 1; i < meetingsSize; i++) {
        int* lastMerged = mergedIntervals[mergedCount - 1];
        int* currentMeeting = meetings[i];

        if (currentMeeting[0] <= lastMerged[1]) {
            lastMerged[1] = max(lastMerged[1], currentMeeting[1]);
        } else {
            mergedIntervals[mergedCount] = (int*)malloc(2 * sizeof(int));
            if (mergedIntervals[mergedCount] == NULL) {
                for (int j = 0; j < mergedCount; j++) {
                    free(mergedIntervals[j]);
                }
                free(mergedIntervals);
                return 0;
            }
            mergedIntervals[mergedCount][0] = currentMeeting[0];
            mergedIntervals[mergedCount][1] = currentMeeting[1];
            mergedCount++;
        }
    }

    int maxFreeTime = 0;

    for (int i = 1; i < mergedCount; i++) {
        int gap = mergedIntervals[i][0] - mergedIntervals[i-1][1];
        maxFreeTime = max(maxFreeTime, gap);
    }

    for (int i = 0; i < mergedCount; i++) {
        free(mergedIntervals[i]);
    }
    free(mergedIntervals);

    return maxFreeTime;
}