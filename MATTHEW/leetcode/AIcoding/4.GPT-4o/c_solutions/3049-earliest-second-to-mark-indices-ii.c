int earliestFullMark(int* times, int timesSize, int* marks, int marksSize) {
    int lastMarked[1001] = {0};
    for (int i = 0; i < marksSize; i++) {
        lastMarked[marks[i]] = 1;
    }

    int count = 0;
    for (int i = 0; i < timesSize; i++) {
        if (lastMarked[times[i]]) {
            count++;
            lastMarked[times[i]] = 0; // Mark as counted
        }
        if (count == marksSize) {
            return i + 1;
        }
    }
    return -1;
}