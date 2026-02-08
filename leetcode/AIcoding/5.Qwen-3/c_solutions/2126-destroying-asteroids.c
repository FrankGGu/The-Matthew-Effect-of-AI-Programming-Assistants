#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool canDestroyAsteroids(int* asteroids, int asteroidsSize, int mass) {
    qsort(asteroids, asteroidsSize, sizeof(int), compare);
    for (int i = 0; i < asteroidsSize; i++) {
        if (mass < asteroids[i]) {
            return false;
        }
        mass += asteroids[i];
    }
    return true;
}