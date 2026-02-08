#include <stdio.h>
#include <stdlib.h>

int leastInterval(char* tasks, int tasksSize, int n) {
    int freq[26] = {0};
    for (int i = 0; i < tasksSize; i++) {
        freq[tasks[i] - 'A']++;
    }

    int max_freq = 0;
    int count_max_freq = 0;

    for (int i = 0; i < 26; i++) {
        if (freq[i] > max_freq) {
            max_freq = freq[i];
            count_max_freq = 1;
        } else if (freq[i] == max_freq) {
            count_max_freq++;
        }
    }

    int part = (max_freq - 1) * (n + 1);
    int extra = count_max_freq;
    return part + extra;
}