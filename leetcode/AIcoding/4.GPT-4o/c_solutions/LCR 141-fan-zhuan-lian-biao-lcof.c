int canComplete(int* gain, int gainSize, int* time, int timeSize, int target) {
    int totalGain = 0;
    for (int i = 0; i < gainSize; i++) {
        totalGain += gain[i];
    }

    int totalTime = 0;
    for (int i = 0; i < timeSize; i++) {
        totalTime += time[i];
    }

    if (totalGain < target || totalTime < target) {
        return 0;
    }

    int currentGain = 0;
    int currentTime = 0;
    for (int i = 0; i < gainSize; i++) {
        currentGain += gain[i];
        currentTime += time[i];
        if (currentGain >= target) {
            return 1;
        }
        if (currentTime >= target) {
            break;
        }
    }

    return 0;
}