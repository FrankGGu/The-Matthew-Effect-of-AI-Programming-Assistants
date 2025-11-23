int leastInterval(char *tasks, int tasksSize, int n) {
    int counts[26] = {0};
    for (int i = 0; i < tasksSize; i++) {
        counts[tasks[i] - 'A']++;
    }

    int maxCount = 0;
    int maxCountFreq = 0;

    for (int i = 0; i < 26; i++) {
        if (counts[i] > maxCount) {
            maxCount = counts[i];
            maxCountFreq = 1;
        } else if (counts[i] == maxCount) {
            maxCountFreq++;
        }
    }

    int partCount = maxCount - 1;
    int partLength = n - (maxCountFreq - 1);
    int emptySlots = partCount * partLength;
    int availableTasks = tasksSize - maxCount * maxCountFreq;
    int idles = emptySlots - availableTasks;

    return tasksSize + (idles > 0 ? idles : 0);
}