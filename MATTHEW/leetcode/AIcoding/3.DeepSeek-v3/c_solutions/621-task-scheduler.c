int leastInterval(char* tasks, int tasksSize, int n) {
    int freq[26] = {0};
    int maxFreq = 0;
    int maxCount = 0;

    for (int i = 0; i < tasksSize; i++) {
        freq[tasks[i] - 'A']++;
        if (freq[tasks[i] - 'A'] > maxFreq) {
            maxFreq = freq[tasks[i] - 'A'];
            maxCount = 1;
        } else if (freq[tasks[i] - 'A'] == maxFreq) {
            maxCount++;
        }
    }

    int partCount = maxFreq - 1;
    int partLength = n - (maxCount - 1);
    int emptySlots = partCount * partLength;
    int availableTasks = tasksSize - maxFreq * maxCount;
    int idles = emptySlots - availableTasks > 0 ? emptySlots - availableTasks : 0;

    return tasksSize + idles;
}