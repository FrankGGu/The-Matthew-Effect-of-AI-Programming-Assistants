#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

typedef struct {
    int x, y1, y2, type;
} Event;

int compare(const void *a, const void *b) {
    Event *ea = (Event *)a;
    Event *eb = (Event *)b;
    if (ea->x != eb->x) return ea->x - eb->x;
    return ea->type - eb->type;
}

int rectangleArea(int** rectangles, int rectanglesSize, int* rectanglesColSize){
    int n = rectanglesSize;
    Event events[2 * n];
    int yCoords[2 * n];
    int yCoordsSize = 0;

    for (int i = 0; i < n; i++) {
        events[2 * i].x = rectangles[i][0];
        events[2 * i].y1 = rectangles[i][1];
        events[2 * i].y2 = rectangles[i][3];
        events[2 * i].type = 1;
        yCoords[yCoordsSize++] = rectangles[i][1];
        yCoords[yCoordsSize++] = rectangles[i][3];

        events[2 * i + 1].x = rectangles[i][2];
        events[2 * i + 1].y1 = rectangles[i][1];
        events[2 * i + 1].y2 = rectangles[i][3];
        events[2 * i + 1].type = -1;
    }

    qsort(events, 2 * n, sizeof(Event), compare);
    qsort(yCoords, yCoordsSize, sizeof(int), compare);

    int uniqueYCoords[2 * n];
    int uniqueYCoordsSize = 0;
    if (yCoordsSize > 0) {
        uniqueYCoords[uniqueYCoordsSize++] = yCoords[0];
        for (int i = 1; i < yCoordsSize; i++) {
            if (yCoords[i] != yCoords[i - 1]) {
                uniqueYCoords[uniqueYCoordsSize++] = yCoords[i];
            }
        }
    }

    long long area = 0;
    int active[2 * n];
    for (int i = 0; i < uniqueYCoordsSize; i++) {
        active[i] = 0;
    }

    for (int i = 0; i < 2 * n; i++) {
        if (i > 0) {
            int coveredLength = 0;
            int currentY = uniqueYCoords[0];
            for (int j = 0; j < uniqueYCoordsSize; j++) {
                if (active[j] > 0) {
                    coveredLength += uniqueYCoords[j + 1] - uniqueYCoords[j];
                }
            }
            area = (area + (long long)coveredLength * (events[i].x - events[i - 1].x)) % MOD;
        }

        int y1 = events[i].y1, y2 = events[i].y2, type = events[i].type;
        for (int j = 0; j < uniqueYCoordsSize; j++) {
            if (uniqueYCoords[j] >= y1 && uniqueYCoords[j + 1] <= y2) {
                active[j] += type;
            }
        }
    }
    return (int)area;
}