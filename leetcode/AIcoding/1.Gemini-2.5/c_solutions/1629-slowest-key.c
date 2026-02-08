char slowestKey(int* releaseTimes, int releaseTimesSize, char* keysPressed) {
    int max_duration = 0;
    char slowest_key = ' '; 
    int prev_release_time = 0;

    for (int i = 0; i < releaseTimesSize; i++) {
        int current_duration = releaseTimes[i] - prev_release_time;

        if (current_duration > max_duration) {
            max_duration = current_duration;
            slowest_key = keysPressed[i];
        } else if (current_duration == max_duration) {
            if (keysPressed[i] > slowest_key) {
                slowest_key = keysPressed[i];
            }
        }
        prev_release_time = releaseTimes[i];
    }

    return slowest_key;
}