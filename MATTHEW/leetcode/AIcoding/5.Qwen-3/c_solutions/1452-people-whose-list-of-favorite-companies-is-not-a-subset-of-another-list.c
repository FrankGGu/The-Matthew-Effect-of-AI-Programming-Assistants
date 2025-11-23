#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** peopleQueries(int** favoriteCompanies, int favoriteCompaniesSize, int* favoriteCompaniesColSize, int* returnSize) {
    int** result = (int**)malloc(favoriteCompaniesSize * sizeof(int*));
    *returnSize = 0;

    for (int i = 0; i < favoriteCompaniesSize; i++) {
        int isSubset = 0;
        for (int j = 0; j < favoriteCompaniesSize; j++) {
            if (i == j) continue;
            int count = 0;
            for (int k = 0; k < favoriteCompaniesColSize[i]; k++) {
                for (int l = 0; l < favoriteCompaniesColSize[j]; l++) {
                    if (favoriteCompanies[i][k] == favoriteCompanies[j][l]) {
                        count++;
                        break;
                    }
                }
            }
            if (count == favoriteCompaniesColSize[i]) {
                isSubset = 1;
                break;
            }
        }
        if (!isSubset) {
            result[*returnSize] = (int*)malloc(sizeof(int));
            result[*returnSize][0] = i;
            (*returnSize)++;
        }
    }

    return result;
}