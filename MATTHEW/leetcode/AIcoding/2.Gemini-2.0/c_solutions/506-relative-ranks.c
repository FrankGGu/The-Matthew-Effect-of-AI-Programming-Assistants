#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** findRelativeRanks(int* score, int scoreSize, int* returnSize){
    int* sortedScore = (int*)malloc(sizeof(int) * scoreSize);
    memcpy(sortedScore, score, sizeof(int) * scoreSize);

    for (int i = 0; i < scoreSize; i++) {
        for (int j = i + 1; j < scoreSize; j++) {
            if (sortedScore[i] < sortedScore[j]) {
                int temp = sortedScore[i];
                sortedScore[i] = sortedScore[j];
                sortedScore[j] = temp;
            }
        }
    }

    char **result = (char**)malloc(sizeof(char*) * scoreSize);
    *returnSize = scoreSize;

    for (int i = 0; i < scoreSize; i++) {
        result[i] = (char*)malloc(sizeof(char) * 20); 
    }

    for (int i = 0; i < scoreSize; i++) {
        int rank = -1;
        for (int j = 0; j < scoreSize; j++) {
            if (score[i] == sortedScore[j]) {
                rank = j;
                break;
            }
        }

        if (rank == 0) {
            strcpy(result[i], "Gold Medal");
        } else if (rank == 1) {
            strcpy(result[i], "Silver Medal");
        } else if (rank == 2) {
            strcpy(result[i], "Bronze Medal");
        } else {
            sprintf(result[i], "%d", rank + 1);
        }
    }

    free(sortedScore);
    return result;
}