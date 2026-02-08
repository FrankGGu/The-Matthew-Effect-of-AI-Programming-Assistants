#include <stdio.h>
#include <stdlib.h>

int leastInterval(char* tasks, int n) {
    int count[26] = {0};
    int max_freq = 0;
    int num_max_freq = 0;

    for (int i = 0; tasks[i] != '\0'; i++) {
        int idx = tasks[i] - 'A';
        count[idx]++;
        if (count[idx] > max_freq) {
            max_freq = count[idx];
            num_max_freq = 1;
        } else if (count[idx] == max_freq) {
            num_max_freq++;
        }
    }

    int part1 = (max_freq - 1) * (n + 1);
    int part2 = num_max_freq;
    return part1 + part2;
}