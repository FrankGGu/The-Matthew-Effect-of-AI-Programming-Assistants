#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int leastInterval(char* tasks, int tasksSize, int n) {
    int freq[26] = {0};
    for (int i = 0; i < tasksSize; i++) {
        freq[tasks[i] - 'A']++;
    }

    int maxFreq = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > maxFreq) {
            maxFreq = freq[i];
        }
    }

    int maxFreqCount = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] == maxFreq) {
            maxFreqCount++;
        }
    }

    int result = (maxFreq - 1) * (n + 1) + maxFreqCount;

    return result > tasksSize ? result : tasksSize;
}