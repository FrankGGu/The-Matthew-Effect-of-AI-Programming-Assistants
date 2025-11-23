int minTimeToUnlock(int* locks, int locksSize) {
    int minTime = 0;
    for (int i = 0; i < locksSize; i++) {
        minTime += locks[i];
    }
    return minTime;
}