int canReachEnd(int* a, int aSize) {
    int maxReach = 0;
    for (int i = 0; i < aSize; i++) {
        if (i > maxReach) return 0;
        maxReach = fmax(maxReach, i + a[i]);
    }
    return 1;
}