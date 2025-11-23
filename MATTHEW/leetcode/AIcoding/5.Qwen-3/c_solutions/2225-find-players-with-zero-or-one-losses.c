#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int losses;
} Player;

typedef struct {
    char* name;
    int lossCount;
} Result;

int compare(const void* a, const void* b) {
    return strcmp(((Player*)a)->name, ((Player*)b)->name);
}

int compareResult(const void* a, const void* b) {
    return strcmp(((Result*)a)->name, ((Result*)b)->name);
}

char** findPlayersWithZeroOrOneLosses(char*** players, int playersSize, int* returnSize) {
    int* lossCount = (int*)calloc(playersSize, sizeof(int));
    char** result = NULL;
    *returnSize = 0;

    for (int i = 0; i < playersSize; i++) {
        char* name = players[i][0];
        int loss = atoi(players[i][1]);
        lossCount[i] = loss;
    }

    Player* playerList = (Player*)malloc(playersSize * sizeof(Player));
    for (int i = 0; i < playersSize; i++) {
        playerList[i].name = strdup(players[i][0]);
        playerList[i].losses = lossCount[i];
    }

    qsort(playerList, playersSize, sizeof(Player), compare);

    for (int i = 0; i < playersSize; i++) {
        if (playerList[i].losses == 0 || playerList[i].losses == 1) {
            (*returnSize)++;
        }
    }

    result = (char**)malloc(*returnSize * sizeof(char*));
    int index = 0;

    for (int i = 0; i < playersSize; i++) {
        if (playerList[i].losses == 0 || playerList[i].losses == 1) {
            result[index++] = strdup(playerList[i].name);
        }
    }

    free(lossCount);
    for (int i = 0; i < playersSize; i++) {
        free(playerList[i].name);
    }
    free(playerList);

    return result;
}