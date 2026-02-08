#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int score;
    int index;
} ScoreIndex;

int compare(const void *a, const void *b) {
    return ((ScoreIndex *)b)->score - ((ScoreIndex *)a)->score;
}

char** findRelativeRanks(int* scores, int scoresSize, int* returnSize) {
    ScoreIndex *si = (ScoreIndex *)malloc(scoresSize * sizeof(ScoreIndex));
    for (int i = 0; i < scoresSize; i++) {
        si[i].score = scores[i];
        si[i].index = i;
    }

    qsort(si, scoresSize, sizeof(ScoreIndex), compare);

    char **result = (char **)malloc(scoresSize * sizeof(char *));
    for (int i = 0; i < scoresSize; i++) {
        result[i] = (char *)malloc(12 * sizeof(char));
    }

    for (int i = 0; i < scoresSize; i++) {
        if (i == 0) {
            strcpy(result[si[i].index], "Gold Medal");
        } else if (i == 1) {
            strcpy(result[si[i].index], "Silver Medal");
        } else if (i == 2) {
            strcpy(result[si[i].index], "Bronze Medal");
        } else {
            sprintf(result[si[i].index], "%d", i + 1);
        }
    }

    *returnSize = scoresSize;
    free(si);
    return result;
}