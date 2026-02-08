#include <stdio.h>
#include <stdlib.h>

int maximumPopulation(int** people, int peopleSize, int* peopleColSize) {
    int* birth = (int*)malloc(101 * sizeof(int));
    int* death = (int*)malloc(101 * sizeof(int));
    for (int i = 0; i < 101; i++) {
        birth[i] = 0;
        death[i] = 0;
    }

    for (int i = 0; i < peopleSize; i++) {
        int b = people[i][0];
        int d = people[i][1];
        birth[b - 1950]++;
        death[d - 1950]++;
    }

    int maxPop = 0;
    int currentPop = 0;
    int year = 1950;

    for (int i = 0; i < 100; i++) {
        currentPop += birth[i];
        if (currentPop > maxPop) {
            maxPop = currentPop;
            year = 1950 + i;
        }
        currentPop -= death[i];
    }

    free(birth);
    free(death);
    return year;
}