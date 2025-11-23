#include <stdlib.h>

typedef struct {
    int p1;
    int p2;
} ProductPair;

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int compareProductPairs(const void* a, const void* b) {
    ProductPair* pairA = (ProductPair*)a;
    ProductPair* pairB = (ProductPair*)b;

    if (pairA->p1 != pairB->p1) {
        return pairA->p1 - pairB->p1;
    }
    return pairA->p2 - pairB->p2;
}

int** findProductRecommendationPairs(int** orders, int ordersSize, int* ordersColSize, int* returnSize, int** returnColumnSizes) {
    ProductPair* allPairs = NULL;
    int allPairsCapacity = 0;
    int allPairsSize = 0;

    for (int i = 0; i < ordersSize; i++) {
        int* currentOrder = orders[i];
        int currentOrderSize = ordersColSize[i];

        qsort(currentOrder, currentOrderSize, sizeof(int), compareInts);

        for (int j = 0; j < currentOrderSize; j++) {
            for (int k = j + 1; k < currentOrderSize; k++) {
                if (allPairsSize == allPairsCapacity) {
                    allPairsCapacity = (allPairsCapacity == 0) ? 16 : allPairsCapacity * 2;
                    allPairs = (ProductPair*)realloc(allPairs, allPairsCapacity * sizeof(ProductPair));
                }
                allPairs[allPairsSize].p1 = currentOrder[j];
                allPairs[allPairsSize].p2 = currentOrder[k];
                allPairsSize++;
            }
        }
    }

    if (allPairsSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    qsort(allPairs, allPairsSize, sizeof(ProductPair), compareProductPairs);

    int** result = NULL;
    int resultCapacity = 0;
    int currentResultSize = 0;

    int* colSizes = NULL;

    int currentP1 = allPairs[0].p1;
    int currentP2 = allPairs[0].p2;
    int currentCount = 1;

    for (int i = 1; i < allPairsSize; i++) {
        if (allPairs[i].p1 == currentP1 && allPairs[i].p2 == currentP2) {
            currentCount++;
        } else {
            if (currentResultSize == resultCapacity) {
                resultCapacity = (resultCapacity == 0) ? 16 : resultCapacity * 2;
                result = (int**)realloc(result, resultCapacity * sizeof(int*));
                colSizes = (int*)realloc(colSizes, resultCapacity * sizeof(int));
            }
            result[currentResultSize] = (int*)malloc(3 * sizeof(int));
            result[currentResultSize][0] = currentP1;
            result[currentResultSize][1] = currentP2;
            result[currentResultSize][2] = currentCount;
            colSizes[currentResultSize] = 3;
            currentResultSize++;

            currentP1 = allPairs[i].p1;
            currentP2 = allPairs[i].p2;
            currentCount = 1;
        }
    }

    if (currentResultSize == resultCapacity) {
        resultCapacity = (resultCapacity == 0) ? 16 : resultCapacity * 2;
        result = (int**)realloc(result, resultCapacity * sizeof(int*));
        colSizes = (int*)realloc(colSizes, resultCapacity * sizeof(int));
    }
    result[currentResultSize] = (int*)malloc(3 * sizeof(int));
    result[currentResultSize][0] = currentP1;
    result[currentResultSize][1] = currentP2;
    result[currentResultSize][2] = currentCount;
    colSizes[currentResultSize] = 3;
    currentResultSize++;

    free(allPairs);

    *returnSize = currentResultSize;
    *returnColumnSizes = colSizes;

    return result;
}