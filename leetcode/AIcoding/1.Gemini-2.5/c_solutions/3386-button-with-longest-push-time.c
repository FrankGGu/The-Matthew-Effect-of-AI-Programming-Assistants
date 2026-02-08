char slowestKey(int* releaseTimes, int releaseTimesSize, char* keysPressed) {
    int maxDuration = releaseTimes[0];
    char resultKey = keysPressed[0];

    for (int i = 1; i < releaseTimesSize; i++) {
        int currentDuration = releaseTimes[i] - releaseTimes[i - 1];
        if (currentDuration > maxDuration) {
            maxDuration = currentDuration;
            resultKey = keysPressed[i];
        } else if (currentDuration == maxDuration) {
            if (keysPressed[i] > resultKey) {
                resultKey = keysPressed[i];
            }
        }
    }

    return resultKey;
}