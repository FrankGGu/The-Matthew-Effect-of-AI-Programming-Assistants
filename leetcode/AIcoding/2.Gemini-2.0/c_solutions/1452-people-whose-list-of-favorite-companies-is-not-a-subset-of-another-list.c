#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* peopleIndexes(char*** favoriteCompanies, int favoriteCompaniesSize, int* favoriteCompaniesColSize, int* returnSize) {
    int* result = (int*)malloc(favoriteCompaniesSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < favoriteCompaniesSize; i++) {
        int isSubset = 0;
        for (int j = 0; j < favoriteCompaniesSize; j++) {
            if (i == j) continue;

            int i_size = favoriteCompaniesColSize[i];
            int j_size = favoriteCompaniesColSize[j];

            if (i_size > j_size) continue;

            int count = 0;
            for (int k = 0; k < i_size; k++) {
                for (int l = 0; l < j_size; l++) {
                    if (strcmp(favoriteCompanies[i][k], favoriteCompanies[j][l]) == 0) {
                        count++;
                        break;
                    }
                }
            }

            if (count == i_size) {
                isSubset = 1;
                break;
            }
        }

        if (!isSubset) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}