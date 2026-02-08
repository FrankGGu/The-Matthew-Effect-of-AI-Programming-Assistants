int earliestFullMark(int* marks, int marksSize) {
    int count[marksSize + 1];
    memset(count, 0, sizeof(count));

    for (int i = 0; i < marksSize; i++) {
        count[marks[i]]++;
    }

    for (int i = 0; i < marksSize + 1; i++) {
        if (count[i] == 0) {
            return i;
        }
    }

    return -1; // This line should never be reached
}