#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(long long*)a - *(long long*)b);
}

int asteroidsDestroyed(int mass, int* asteroids, int asteroidsSize) {
    long long current_mass = mass;
    qsort(asteroids, asteroidsSize, sizeof(int), cmp);

    for (int i = 0; i < asteroidsSize; i++) {
        if (current_mass < asteroids[i]) {
            return 0;
        }
        current_mass += asteroids[i];
    }
    return 1;
}