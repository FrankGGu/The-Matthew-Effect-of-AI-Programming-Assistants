#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int*)a)[0] - ((int*)b)[0];
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int mostBooked(int n, int** meetings, int meetingsSize, int* meetingsColSize) {
    qsort(meetings, meetingsSize, sizeof(meetings[0]), compare);

    long long rooms_end_time[n];
    int rooms_count[n];

    for (int i = 0; i < n; i++) {
        rooms_end_time[i] = 0;
        rooms_count[i] = 0;
    }

    for (int i = 0; i < meetingsSize; i++) {
        int start = meetings[i][0];
        int end = meetings[i][1];
        long long min_end_time = -1;
        int min_end_time_index = -1;
        int available_room_index = -1;

        for (int j = 0; j < n; j++) {
            if (rooms_end_time[j] <= start) {
                available_room_index = j;
                break;
            }
            if (min_end_time == -1 || rooms_end_time[j] < min_end_time) {
                min_end_time = rooms_end_time[j];
                min_end_time_index = j;
            }
        }

        if (available_room_index != -1) {
            rooms_end_time[available_room_index] = end;
            rooms_count[available_room_index]++;
        } else {
            rooms_end_time[min_end_time_index] += (end - start);
            rooms_count[min_end_time_index]++;
        }
    }

    int max_count = 0;
    int max_count_index = 0;

    for (int i = 0; i < n; i++) {
        if (rooms_count[i] > max_count) {
            max_count = rooms_count[i];
            max_count_index = i;
        }
    }

    return max_count_index;
}