#include <stdbool.h> // Required for 'bool' type

int numberOfPoints(int** cars, int carsSize, int* carsColSize){
    bool covered[101] = {false};
    int count = 0;

    for (int i = 0; i < carsSize; i++) {
        int start = cars[i][0];
        int end = cars[i][1];
        for (int j = start; j <= end; j++) {
            covered[j] = true;
        }
    }

    for (int i = 1; i <= 100; i++) {
        if (covered[i]) {
            count++;
        }
    }

    return count;
}