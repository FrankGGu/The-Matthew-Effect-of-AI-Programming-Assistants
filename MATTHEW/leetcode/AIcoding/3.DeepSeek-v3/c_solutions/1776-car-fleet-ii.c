typedef struct {
    int position;
    int speed;
} Car;

typedef struct {
    int index;
    double time;
} Collision;

double* getCollisionTimes(int** cars, int carsSize, int* carsColSize, int* returnSize) {
    double* res = (double*)malloc(carsSize * sizeof(double));
    for (int i = 0; i < carsSize; i++) {
        res[i] = -1.0;
    }

    Collision* stack = (Collision*)malloc(carsSize * sizeof(Collision));
    int top = -1;

    for (int i = carsSize - 1; i >= 0; i--) {
        int pos = cars[i][0];
        int speed = cars[i][1];

        while (top >= 0) {
            int j = stack[top].index;
            int nextPos = cars[j][0];
            int nextSpeed = cars[j][1];

            if (speed <= nextSpeed || 
                (res[j] > 0 && (double)(nextPos - pos) / (speed - nextSpeed) >= res[j])) {
                top--;
            } else {
                break;
            }
        }

        if (top >= 0) {
            int j = stack[top].index;
            int nextPos = cars[j][0];
            int nextSpeed = cars[j][1];
            res[i] = (double)(nextPos - pos) / (speed - nextSpeed);
        }

        stack[++top] = (Collision){i, res[i]};
    }

    free(stack);
    *returnSize = carsSize;
    return res;
}