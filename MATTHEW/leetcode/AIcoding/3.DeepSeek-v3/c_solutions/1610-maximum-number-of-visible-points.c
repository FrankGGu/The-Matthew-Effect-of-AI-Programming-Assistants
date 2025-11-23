#define _USE_MATH_DEFINES
#include <math.h>
#include <stdlib.h>

typedef struct {
    double angle;
    int type;
} Event;

int compare(const void* a, const void* b) {
    Event* e1 = (Event*)a;
    Event* e2 = (Event*)b;
    if (e1->angle == e2->angle) {
        return e2->type - e1->type;
    }
    return e1->angle > e2->angle ? 1 : -1;
}

int visiblePoints(int** points, int pointsSize, int* pointsColSize, int angle, int* location, int locationSize) {
    int base = 0;
    Event* events = malloc(2 * pointsSize * sizeof(Event));
    int eventsSize = 0;
    double angle_rad = angle * M_PI / 180.0;

    for (int i = 0; i < pointsSize; i++) {
        int dx = points[i][0] - location[0];
        int dy = points[i][1] - location[1];
        if (dx == 0 && dy == 0) {
            base++;
            continue;
        }
        double theta = atan2(dy, dx);
        events[eventsSize].angle = theta;
        events[eventsSize].type = 1;
        eventsSize++;
        events[eventsSize].angle = theta + 2 * M_PI;
        events[eventsSize].type = 1;
        eventsSize++;
    }

    qsort(events, eventsSize, sizeof(Event), compare);

    int res = base;
    int count = base;
    int left = 0;

    for (int right = 0; right < eventsSize; right++) {
        if (events[right].type == 1) {
            count++;
        }
        while (events[right].angle - events[left].angle > angle_rad + 1e-9) {
            if (events[left].type == 1) {
                count--;
            }
            left++;
        }
        if (count > res) {
            res = count;
        }
    }

    free(events);
    return res;
}