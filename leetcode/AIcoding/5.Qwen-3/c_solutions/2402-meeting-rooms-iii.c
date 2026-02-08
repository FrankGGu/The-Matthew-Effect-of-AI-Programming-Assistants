#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Interval;

int compare(const void* a, const void* b) {
    Interval* x = (Interval*)a;
    Interval* y = (Interval*)b;
    return x->start - y->start;
}

int mostBooked(int** intervals, int n, int* m) {
    qsort(intervals, n, sizeof(Interval), compare);

    int* rooms = (int*)malloc(*m * sizeof(int));
    for (int i = 0; i < *m; i++) {
        rooms[i] = 0;
    }

    int maxRooms = 0;
    for (int i = 0; i < n; i++) {
        int minRoom = 0;
        for (int j = 1; j < *m; j++) {
            if (rooms[j] < rooms[minRoom]) {
                minRoom = j;
            }
        }

        if (rooms[minRoom] <= intervals[i][0]) {
            rooms[minRoom] = intervals[i][1];
        } else {
            for (int j = 0; j < *m; j++) {
                if (rooms[j] == rooms[minRoom]) {
                    rooms[j] = intervals[i][1];
                    break;
                }
            }
        }

        int count = 0;
        for (int j = 0; j < *m; j++) {
            if (rooms[j] > 0) {
                count++;
            }
        }
        maxRooms = (count > maxRooms) ? count : maxRooms;
    }

    free(rooms);
    return maxRooms;
}