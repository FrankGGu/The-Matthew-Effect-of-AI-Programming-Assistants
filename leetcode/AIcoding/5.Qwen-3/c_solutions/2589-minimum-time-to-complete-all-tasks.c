#include <stdio.h>
#include <stdlib.h>

int leastInterval(char* tasks, int n) {
    int freq[26] = {0};
    int max_freq = 0;
    int count_max_freq = 0;

    for (int i = 0; tasks[i] != '\0'; i++) {
        int idx = tasks[i] - 'A';
        freq[idx]++;
        if (freq[idx] > max_freq) {
            max_freq = freq[idx];
            count_max_freq = 1;
        } else if (freq[idx] == max_freq) {
            count_max_freq++;
        }
    }

    int part1 = (max_freq - 1) * (n + 1);
    int part2 = count_max_freq;
    return part1 + part2;
}