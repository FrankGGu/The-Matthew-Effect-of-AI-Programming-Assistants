#include <stdlib.h>

typedef struct {
    int position;
    double time_to_target;
} Car;

int compareCars(const void *a, const void *b) {
    Car *carA = (Car *)a;
    Car *carB = (Car *)b;
    // Sort by position in descending order
    return carB->position - carA->position;
}

int carFleet(int target, int* position, int positionSize, int* speed, int speedSize) {
    if (positionSize == 0) {
        return 0;
    }

    Car* cars = (Car*)malloc(positionSize * sizeof(Car));
    if (cars == NULL) {
        return 0; 
    }

    for (int i = 0; i < positionSize; i++) {
        cars[i].position = position[i];
        cars[i].time_to_target = (double)(target - position[i]) / speed[i];
    }

    qsort(cars, positionSize, sizeof(Car), compareCars);

    int fleets = 0;
    double max_time_seen = 0.0; 

    for (int i = 0; i < positionSize; i++) {
        if (cars[i].time_to_target > max_time_seen) {
            fleets++;
            max_time_seen = cars[i].time_to_target;
        }
    }

    free(cars);
    return fleets;
}