#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

int compare(const void* a, const void* b) {
    Interval* intervalA = (Interval*)a;
    Interval* intervalB = (Interval*)b;
    if (intervalA->start == intervalB->start) {
        return intervalA->end - intervalB->end;
    }
    return intervalA->start - intervalB->start;
}

int mostBooked(int n, int** meetings, int meetingsSize, int* meetingsColSize) {
    Interval* intervals = (Interval*)malloc(meetingsSize * sizeof(Interval));
    for (int i = 0; i < meetingsSize; i++) {
        intervals[i].start = meetings[i][0];
        intervals[i].end = meetings[i][1];
    }

    qsort(intervals, meetingsSize, sizeof(Interval), compare);

    long long* roomAvailableTime = (long long*)malloc(n * sizeof(long long));
    int* roomCount = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        roomAvailableTime[i] = 0;
        roomCount[i] = 0;
    }

    for (int i = 0; i < meetingsSize; i++) {
        int start = intervals[i].start;
        int end = intervals[i].end;

        int found = 0;
        int minRoomIndex = -1;
        long long minAvailableTime = __LONG_LONG_MAX__;

        for (int j = 0; j < n; j++) {
            if (roomAvailableTime[j] <= start) {
                roomAvailableTime[j] = end;
                roomCount[j]++;
                found = 1;
                break;
            }

            if (roomAvailableTime[j] < minAvailableTime) {
                minAvailableTime = roomAvailableTime[j];
                minRoomIndex = j;
            }
        }

        if (!found) {
            roomAvailableTime[minRoomIndex] += (end - start);
            roomCount[minRoomIndex]++;
        }
    }

    int maxCount = 0;
    int result = 0;
    for (int i = 0; i < n; i++) {
        if (roomCount[i] > maxCount) {
            maxCount = roomCount[i];
            result = i;
        }
    }

    free(intervals);
    free(roomAvailableTime);
    free(roomCount);

    return result;
}