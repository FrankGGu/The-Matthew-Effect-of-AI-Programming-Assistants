bool asteroidsDestroyed(int mass, int* asteroids, int asteroidsSize) {
    long long currentMass = mass;
    qsort(asteroids, asteroidsSize, sizeof(int), cmp);
    for (int i = 0; i < asteroidsSize; i++) {
        if (currentMass >= asteroids[i]) {
            currentMass += asteroids[i];
        } else {
            return false;
        }
    }
    return true;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}