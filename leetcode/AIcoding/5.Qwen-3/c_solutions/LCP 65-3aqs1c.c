#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double** highFive(int** items, int itemsSize, int* itemsColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(100 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(100 * sizeof(int));
    *returnSize = 0;

    int maxId = 0;
    for (int i = 0; i < itemsSize; i++) {
        if (items[i][0] > maxId) {
            maxId = items[i][0];
        }
    }

    int** scores = (int**)malloc((maxId + 1) * sizeof(int*));
    for (int i = 0; i <= maxId; i++) {
        scores[i] = (int*)malloc(5 * sizeof(int));
        for (int j = 0; j < 5; j++) {
            scores[i][j] = -1;
        }
    }

    for (int i = 0; i < itemsSize; i++) {
        int id = items[i][0];
        int score = items[i][1];
        int pos = 0;
        while (pos < 5 && scores[id][pos] != -1) {
            pos++;
        }
        if (pos < 5) {
            scores[id][pos] = score;
        }
    }

    for (int i = 0; i <= maxId; i++) {
        int sum = 0;
        int count = 0;
        for (int j = 0; j < 5; j++) {
            if (scores[i][j] != -1) {
                sum += scores[i][j];
                count++;
            }
        }
        if (count > 0) {
            result[*returnSize] = (int*)malloc(2 * sizeof(int));
            result[*returnSize][0] = i;
            result[*returnSize][1] = sum / count;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        }
    }

    for (int i = 0; i <= maxId; i++) {
        free(scores[i]);
    }
    free(scores);

    return result;
}