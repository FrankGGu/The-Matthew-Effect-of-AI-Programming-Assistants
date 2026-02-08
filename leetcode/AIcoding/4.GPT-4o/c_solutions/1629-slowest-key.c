char slowestKey(int* releaseTimes, int releaseTimesSize, char* keysPressed) {
    int maxDuration = 0;
    char result = 0;

    for (int i = 0; i < releaseTimesSize; i++) {
        int duration = releaseTimes[i] - (i == 0 ? 0 : releaseTimes[i - 1]);
        if (duration > maxDuration || (duration == maxDuration && keysPressed[i] > result)) {
            maxDuration = duration;
            result = keysPressed[i];
        }
    }

    return result;
}