#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int miceAndCheese(int* reward1, int reward1Size, int* reward2, int reward2Size, int k) {
    int* diffs = (int*)malloc(reward1Size * sizeof(int));

    for (int i = 0; i < reward1Size; i++) {
        diffs[i] = reward1[i] - reward2[i];
    }

    qsort(diffs, reward1Size, sizeof(int), compare);

    int totalScore = 0;
    for (int i = 0; i < reward2Size; i++) {
        totalScore += reward2[i];
    }

    for (int i = 0; i < k; i++) {
        totalScore += diffs[i];
    }

    free(diffs);

    return totalScore;
}