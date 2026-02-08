#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct {
    int score;
    int originalIndex;
} ScoreEntry;

int compareScoreEntries(const void* a, const void* b) {
    ScoreEntry* entryA = (ScoreEntry*)a;
    ScoreEntry* entryB = (ScoreEntry*)b;
    return entryB->score - entryA->score;
}

char ** findRelativeRanks(int* score, int scoreSize, int* returnSize) {
    *returnSize = scoreSize;

    ScoreEntry* entries = (ScoreEntry*)malloc(scoreSize * sizeof(ScoreEntry));
    if (entries == NULL) {
        return NULL;
    }

    for (int i = 0; i < scoreSize; i++) {
        entries[i].score = score[i];
        entries[i].originalIndex = i;
    }

    qsort(entries, scoreSize, sizeof(ScoreEntry), compareScoreEntries);

    char** result = (char**)malloc(scoreSize * sizeof(char*));
    if (result == NULL) {
        free(entries);
        return NULL;
    }

    for (int i = 0; i < scoreSize; i++) {
        result[entries[i].originalIndex] = (char*)malloc(20 * sizeof(char));
        if (result[entries[i].originalIndex] == NULL) {
            for (int j = 0; j < i; j++) {
                free(result[entries[j].originalIndex]);
            }
            free(result);
            free(entries);
            return NULL;
        }

        if (i == 0) {
            strcpy(result[entries[i].originalIndex], "Gold Medal");
        } else if (i == 1) {
            strcpy(result[entries[i].originalIndex], "Silver Medal");
        } else if (i == 2) {
            strcpy(result[entries[i].originalIndex], "Bronze Medal");
        } else {
            sprintf(result[entries[i].originalIndex], "%d", i + 1);
        }
    }

    free(entries);

    return result;
}