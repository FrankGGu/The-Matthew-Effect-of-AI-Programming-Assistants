#include <stdio.h>
#include <stdlib.h>

long long countDaysWithoutMeetings(int** meetings, int meetingsSize, int* meetingsColSize, int k) {
    int* start = (int*)malloc(meetingsSize * sizeof(int));
    int* end = (int*)malloc(meetingsSize * sizeof(int));
    for (int i = 0; i < meetingsSize; i++) {
        start[i] = meetings[i][0];
        end[i] = meetings[i][1];
    }

    for (int i = 0; i < meetingsSize - 1; i++) {
        for (int j = 0; j < meetingsSize - i - 1; j++) {
            if (start[j] > start[j + 1]) {
                int temp = start[j];
                start[j] = start[j + 1];
                start[j + 1] = temp;
                temp = end[j];
                end[j] = end[j + 1];
                end[j + 1] = temp;
            }
        }
    }

    long long result = 0;
    int prevEnd = 0;
    for (int i = 0; i < meetingsSize; i++) {
        if (start[i] > prevEnd) {
            result += start[i] - prevEnd;
        }
        prevEnd = (end[i] > prevEnd) ? end[i] : prevEnd;
    }

    result += k - prevEnd;

    free(start);
    free(end);

    return result;
}