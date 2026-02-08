#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minMeetingRooms(int** intervals, int intervalsSize, int* intervalsColSize) {
    int *start = (int*)malloc(sizeof(int) * intervalsSize);
    int *end = (int*)malloc(sizeof(int) * intervalsSize);

    for (int i = 0; i < intervalsSize; i++) {
        start[i] = intervals[i][0];
        end[i] = intervals[i][1];
    }

    qsort(start, intervalsSize, sizeof(int), compare);
    qsort(end, intervalsSize, sizeof(int), compare);

    int rooms = 0;
    int startPtr = 0;
    int endPtr = 0;

    while (startPtr < intervalsSize) {
        if (start[startPtr] < end[endPtr]) {
            rooms++;
            startPtr++;
        } else {
            startPtr++;
            endPtr++;
        }
    }

    free(start);
    free(end);

    return rooms;
}

int minMeetingRooms2(int** intervals, int intervalsSize, int* intervalsColSize) {
    int *arrival = (int*)malloc(sizeof(int) * intervalsSize);
    int *departure = (int*)malloc(sizeof(int) * intervalsSize);

    for(int i = 0; i < intervalsSize; i++) {
        arrival[i] = intervals[i][0];
        departure[i] = intervals[i][1];
    }

    qsort(arrival, intervalsSize, sizeof(int), compare);
    qsort(departure, intervalsSize, sizeof(int), compare);

    int rooms = 0;
    int availableRooms = 0;
    int arrivalIndex = 0;
    int departureIndex = 0;

    while(arrivalIndex < intervalsSize) {
        if(arrival[arrivalIndex] < departure[departureIndex]) {
            if(availableRooms == 0) {
                rooms++;
            } else {
                availableRooms--;
            }
            arrivalIndex++;
        } else {
            availableRooms++;
            departureIndex++;
        }
    }
    free(arrival);
    free(departure);

    return rooms;
}

int minMeetingRooms3(int** intervals, int intervalsSize, int* intervalsColSize) {
    int n = intervalsSize;
    int arr[n], dep[n];
    for (int i = 0; i < n; i++) {
        arr[i] = intervals[i][0];
        dep[i] = intervals[i][1];
    }
    qsort(arr, n, sizeof(int), compare);
    qsort(dep, n, sizeof(int), compare);

    int ans = 1, count = 1;
    int i = 1, j = 0;
    while (i < n && j < n) {
        if (arr[i] <= dep[j]) {
            count++;
            i++;
        } else {
            count--;
            j++;
        }
        ans = (count > ans) ? count : ans;
    }
    return ans;
}

int minMeetingRooms4(int** intervals, int intervalsSize, int* intervalsColSize) {
    int* start = (int*)malloc(intervalsSize * sizeof(int));
    int* end = (int*)malloc(intervalsSize * sizeof(int));
    for (int i = 0; i < intervalsSize; i++) {
        start[i] = intervals[i][0];
        end[i] = intervals[i][1];
    }
    qsort(start, intervalsSize, sizeof(int), compare);
    qsort(end, intervalsSize, sizeof(int), compare);
    int rooms = 0, end_index = 0;
    for (int i = 0; i < intervalsSize; i++) {
        if (start[i] < end[end_index]) {
            rooms++;
        } else {
            end_index++;
        }
    }
    free(start);
    free(end);
    return rooms;
}

int minMeetingRooms5(int** intervals, int intervalsSize, int* intervalsColSize){
    int* start = (int*)malloc(intervalsSize * sizeof(int));
    int* end = (int*)malloc(intervalsSize * sizeof(int));

    for (int i = 0; i < intervalsSize; i++) {
        start[i] = intervals[i][0];
        end[i] = intervals[i][1];
    }

    qsort(start, intervalsSize, sizeof(int), compare);
    qsort(end, intervalsSize, sizeof(int), compare);

    int rooms = 0;
    int endIndex = 0;

    for (int i = 0; i < intervalsSize; i++) {
        if (start[i] < end[endIndex]) {
            rooms++;
        } else {
            endIndex++;
        }
    }
    free(start);
    free(end);
    return rooms;
}

int minMeetingRooms(int** intervals, int intervalsSize, int* intervalsColSize){
    int* start = (int*)malloc(intervalsSize * sizeof(int));
    int* end = (int*)malloc(intervalsSize * sizeof(int));

    for (int i = 0; i < intervalsSize; i++) {
        start[i] = intervals[i][0];
        end[i] = intervals[i][1];
    }

    qsort(start, intervalsSize, sizeof(int), compare);
    qsort(end, intervalsSize, sizeof(int), compare);

    int rooms = 0;
    int endIndex = 0;

    for (int i = 0; i < intervalsSize; i++) {
        if (start[i] < end[endIndex]) {
            rooms++;
        } else {
            endIndex++;
        }
    }
    free(start);
    free(end);
    return rooms;
}