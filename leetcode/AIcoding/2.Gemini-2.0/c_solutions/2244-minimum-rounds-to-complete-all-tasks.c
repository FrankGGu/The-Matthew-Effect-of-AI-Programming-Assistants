#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minRounds(int* tasks, int tasksSize) {
    int* freq = (int*)malloc(sizeof(int) * 200001);
    for (int i = 0; i <= 200000; i++) {
        freq[i] = 0;
    }

    for (int i = 0; i < tasksSize; i++) {
        freq[tasks[i]]++;
    }

    int rounds = 0;
    for (int i = 0; i <= 200000; i++) {
        if (freq[i] == 0) continue;

        if (freq[i] == 1) {
            free(freq);
            return -1;
        }

        if (freq[i] % 3 == 0) {
            rounds += freq[i] / 3;
        } else if (freq[i] % 3 == 1) {
            rounds += (freq[i] / 3) - 1 + 2;
        } else {
            rounds += freq[i] / 3 + 1;
        }
    }

    free(freq);
    return rounds;
}