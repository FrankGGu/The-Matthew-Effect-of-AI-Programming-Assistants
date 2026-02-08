#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumRounds(int* tasks, int tasksSize) {
    int count[101] = {0};
    for (int i = 0; i < tasksSize; i++) {
        count[tasks[i]]++;
    }

    int rounds = 0;
    for (int i = 1; i <= 100; i++) {
        if (count[i] == 0) continue;
        if (count[i] == 1) return -1;
        rounds += count[i] / 3;
        if (count[i] % 3 != 0) rounds++;
    }
    return rounds;
}