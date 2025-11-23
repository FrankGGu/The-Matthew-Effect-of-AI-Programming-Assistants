#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int position;
    int speed;
} Car;

int compare(const void* a, const void* b) {
    return ((Car*)b)->position - ((Car*)a)->position;
}

int* getCollisionTimes(int** cars, int carsSize, int* carsColSize, int* returnSize) {
    int n = carsSize;
    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        int pos = cars[i][0];
        int spd = cars[i][1];
        for (int j = i + 1; j < n; j++) {
            int next_pos = cars[j][0];
            int next_spd = cars[j][1];
            if (next_spd <= spd) {
                break;
            }
            int time = (next_pos - pos) / (next_spd - spd);
            if (result[j] == -1 || time < result[j]) {
                result[j] = time;
            }
        }
    }

    *returnSize = n;
    return result;
}