#include <stdlib.h>

typedef struct {
    double time;
    int index;
} Car;

int cmp(const void *a, const void *b) {
    return ((Car *)a)->time > ((Car *)b)->time;
}

int carFleet(int target, int* position, int positionSize, int* speed, int speedSize) {
    Car *cars = (Car *)malloc(positionSize * sizeof(Car));

    for (int i = 0; i < positionSize; i++) {
        cars[i].time = (double)(target - position[i]) / speed[i];
        cars[i].index = i;
    }

    qsort(cars, positionSize, sizeof(Car), cmp);

    int fleets = 0;
    double currTime = 0.0;

    for (int i = positionSize - 1; i >= 0; i--) {
        if (cars[i].time > currTime) {
            fleets++;
            currTime = cars[i].time;
        }
    }

    free(cars);
    return fleets;
}