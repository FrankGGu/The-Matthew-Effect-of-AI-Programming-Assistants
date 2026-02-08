#include <stdbool.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

bool asteroidsDestroyed(long long mass, int* asteroids, int asteroidsSize) {
    qsort(asteroids, asteroidsSize, sizeof(int), compare);

    for (int i = 0; i < asteroidsSize; i++) {
        if (mass >= asteroids[i]) {
            mass += asteroids[i];
        } else {
            return false;
        }
    }
    return true;
}