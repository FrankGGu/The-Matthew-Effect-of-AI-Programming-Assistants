typedef struct {
    int position;
    int speed;
} Car;

int cmp(const void* a, const void* b) {
    Car* carA = (Car*)a;
    Car* carB = (Car*)b;
    return carB->position - carA->position;
}

int carFleet(int target, int* position, int positionSize, int* speed, int speedSize) {
    if (positionSize == 0) return 0;

    Car* cars = (Car*)malloc(positionSize * sizeof(Car));
    for (int i = 0; i < positionSize; i++) {
        cars[i].position = position[i];
        cars[i].speed = speed[i];
    }

    qsort(cars, positionSize, sizeof(Car), cmp);

    double* time = (double*)malloc(positionSize * sizeof(double));
    for (int i = 0; i < positionSize; i++) {
        time[i] = (double)(target - cars[i].position) / cars[i].speed;
    }

    int fleets = 1;
    double maxTime = time[0];
    for (int i = 1; i < positionSize; i++) {
        if (time[i] > maxTime) {
            fleets++;
            maxTime = time[i];
        }
    }

    free(cars);
    free(time);
    return fleets;
}