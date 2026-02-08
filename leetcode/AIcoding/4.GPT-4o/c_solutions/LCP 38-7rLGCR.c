int castleGuard(int** castles, int castlesSize, int* castlesColSize) {
    int total = 0, maxGuard = 0, maxCastle = -1;

    for (int i = 0; i < castlesSize; i++) {
        int guard = 0;
        for (int j = 0; j < castlesColSize[i]; j++) {
            guard += castles[i][j];
        }
        if (guard > maxGuard) {
            maxGuard = guard;
            maxCastle = i;
        }
        total += guard;
    }

    return total - maxGuard;
}