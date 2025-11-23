typedef struct {
    int time;
    int direction;
} Car;

int timeToCross(int n, int** cars, int carsSize, int* carsColSize, int direction) {
    Car* queue[2];
    int front[2] = {0, 0};
    int rear[2] = {0, 0};
    int capacity = carsSize;

    queue[0] = (Car*)malloc(capacity * sizeof(Car));
    queue[1] = (Car*)malloc(capacity * sizeof(Car));

    for (int i = 0; i < carsSize; i++) {
        int dir = cars[i][1];
        queue[dir][rear[dir]++] = (Car){cars[i][0], dir};
    }

    int currentTime = 0;
    int currentDirection = 0;

    while (front[0] < rear[0] || front[1] < rear[1]) {
        int nextTime = INT_MAX;
        if (front[0] < rear[0]) {
            nextTime = fmin(nextTime, queue[0][front[0]].time);
        }
        if (front[1] < rear[1]) {
            nextTime = fmin(nextTime, queue[1][front[1]].time);
        }

        currentTime = fmax(currentTime, nextTime);

        int count = 0;
        int carPassed = 0;

        while (count < n) {
            if (front[currentDirection] < rear[currentDirection] && 
                queue[currentDirection][front[currentDirection]].time <= currentTime) {
                if (carPassed == 0) {
                    carPassed = 1;
                }
                front[currentDirection]++;
                count++;
            } else {
                break;
            }
        }

        if (carPassed) {
            currentTime++;
            currentDirection = 1 - currentDirection;
        } else {
            if (front[1 - currentDirection] < rear[1 - currentDirection] && 
                queue[1 - currentDirection][front[1 - currentDirection]].time <= currentTime) {
                currentDirection = 1 - currentDirection;
            } else {
                currentTime++;
            }
        }
    }

    free(queue[0]);
    free(queue[1]);

    return currentTime;
}