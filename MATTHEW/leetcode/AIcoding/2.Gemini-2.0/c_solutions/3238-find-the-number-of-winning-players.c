#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** findWinners(int** matches, int matchesSize, int* matchesColSize, int* returnSize, int** returnColumnSizes) {
    int max_player = 0;
    for (int i = 0; i < matchesSize; i++) {
        if (matches[i][0] > max_player) {
            max_player = matches[i][0];
        }
        if (matches[i][1] > max_player) {
            max_player = matches[i][1];
        }
    }

    int* losses = (int*)calloc(max_player + 1, sizeof(int));
    for (int i = 0; i < matchesSize; i++) {
        losses[matches[i][1]]++;
    }

    int winners_count = 0;
    int losers_count = 0;
    for (int i = 1; i <= max_player; i++) {
        if (losses[i] == 0) {
            winners_count++;
        } else if (losses[i] == 1) {
            losers_count++;
        }
    }

    int* winners = (int*)malloc(winners_count * sizeof(int));
    int* losers = (int*)malloc(losers_count * sizeof(int));

    int winners_index = 0;
    int losers_index = 0;
    for (int i = 1; i <= max_player; i++) {
        if (losses[i] == 0) {
            winners[winners_index++] = i;
        } else if (losses[i] == 1) {
            losers[losers_index++] = i;
        }
    }

    int** result = (int**)malloc(2 * sizeof(int*));
    result[0] = winners;
    result[1] = losers;

    *returnSize = 2;
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = winners_count;
    (*returnColumnSizes)[1] = losers_count;

    free(losses);
    return result;
}