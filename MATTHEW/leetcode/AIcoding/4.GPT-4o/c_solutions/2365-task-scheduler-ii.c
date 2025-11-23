int leastInterval(char * tasks, int tasksSize, int n) {
    int count[26] = {0};
    for (int i = 0; i < tasksSize; i++) {
        count[tasks[i] - 'A']++;
    }

    int maxCount = 0, maxFreq = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
            maxFreq = 1;
        } else if (count[i] == maxCount) {
            maxFreq++;
        }
    }

    int intervals = (maxCount - 1) * (n + 1) + maxFreq;
    return intervals > tasksSize ? intervals : tasksSize;
}