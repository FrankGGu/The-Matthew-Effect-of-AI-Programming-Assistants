#include <stdio.h>
#include <stdlib.h>

struct Student {
    int id;
    int score;
};

int* findStudentsWhoImproved(int** scores, int scoresSize, int* scoresColSize, int* returnSize) {
    int* result = (int*)malloc(scoresSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < scoresSize; i++) {
        if (scores[i][0] < scores[i][1]) {
            result[(*returnSize)++] = scores[i][0];
        }
    }

    result = realloc(result, (*returnSize) * sizeof(int));
    return result;
}