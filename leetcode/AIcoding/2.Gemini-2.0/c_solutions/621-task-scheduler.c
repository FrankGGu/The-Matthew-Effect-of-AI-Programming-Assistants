#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

    int result = (maxFreq - 1) * (n + 1) + maxCount;
    return (result > tasksSize) ? result : tasksSize;
}