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

    int losses[max_player + 1];
    for (int i = 0; i <= max_player; i++) {
        losses[i] = 0;
    }

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

    int** result = (int**)malloc(2 * sizeof(int*));
    result[0] = (int*)malloc(winners_count * sizeof(int));
    result[1] = (int*)malloc(losers_count * sizeof(int));

    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = winners_count;
    (*returnColumnSizes)[1] = losers_count;
    *returnSize = 2;

    int winners_index = 0;
    int losers_index = 0;
    for (int i = 1; i <= max_player; i++) {
        if (losses[i] == 0) {
            result[0][winners_index++] = i;
        } else if (losses[i] == 1) {
            result[1][losers_index++] = i;
        }
    }

    return result;
}