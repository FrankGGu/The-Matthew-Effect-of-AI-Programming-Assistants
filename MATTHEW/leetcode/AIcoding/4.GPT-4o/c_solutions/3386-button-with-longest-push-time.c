int longestPushTime(int* pushTimes, int pushTimesSize) {
    int maxTime = 0;
    for (int i = 0; i < pushTimesSize; i++) {
        if (pushTimes[i] > maxTime) {
            maxTime = pushTimes[i];
        }
    }
    return maxTime;
}