#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* product1;
    char* product2;
} Pair;

int compare(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

char*** findProductRecommendationPairs(char*** transactions, int transactionsSize, int* transactionsColSize, int* returnSize, int** returnColumnSizes) {
    if (transactionsSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    Pair* pairs = malloc(10000 * sizeof(Pair));
    int pairsCount = 0;

    for (int i = 0; i < transactionsSize; i++) {
        int size = transactionsColSize[i];
        char** transaction = transactions[i];

        qsort(transaction, size, sizeof(char*), compare);

        for (int j = 0; j < size; j++) {
            for (int k = j + 1; k < size; k++) {
                int found = 0;
                for (int m = 0; m < pairsCount; m++) {
                    if ((strcmp(pairs[m].product1, transaction[j]) == 0 && 
                         strcmp(pairs[m].product2, transaction[k]) == 0) ||
                        (strcmp(pairs[m].product1, transaction[k]) == 0 && 
                         strcmp(pairs[m].product2, transaction[j]) == 0)) {
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    pairs[pairsCount].product1 = malloc(strlen(transaction[j]) + 1);
                    strcpy(pairs[pairsCount].product1, transaction[j]);
                    pairs[pairsCount].product2 = malloc(strlen(transaction[k]) + 1);
                    strcpy(pairs[pairsCount].product2, transaction[k]);
                    pairsCount++;
                }
            }
        }
    }

    char*** result = malloc(pairsCount * sizeof(char**));
    *returnColumnSizes = malloc(pairsCount * sizeof(int));

    for (int i = 0; i < pairsCount; i++) {
        result[i] = malloc(2 * sizeof(char*));
        result[i][0] = malloc(strlen(pairs[i].product1) + 1);
        strcpy(result[i][0], pairs[i].product1);
        result[i][1] = malloc(strlen(pairs[i].product2) + 1);
        strcpy(result[i][1], pairs[i].product2);
        (*returnColumnSizes)[i] = 2;
        free(pairs[i].product1);
        free(pairs[i].product2);
    }

    free(pairs);
    *returnSize = pairsCount;
    return result;
}