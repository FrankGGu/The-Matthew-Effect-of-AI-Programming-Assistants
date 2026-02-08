#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct CompanyNode {
    char *company;
    struct CompanyNode *next;
};

struct Person {
    struct CompanyNode *favCompanies;
};

int isSubset(char **a, int aSize, char **b, int bSize) {
    for (int i = 0; i < aSize; i++) {
        int found = 0;
        for (int j = 0; j < bSize; j++) {
            if (strcmp(a[i], b[j]) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) return 0;
    }
    return 1;
}

int* peopleIndexes(char*** favoriteCompanies, int favoriteCompaniesSize, int* favoriteCompaniesColSize, int* returnSize) {
    int *result = malloc(favoriteCompaniesSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < favoriteCompaniesSize; i++) {
        int isSubsetOfAnother = 0;
        for (int j = 0; j < favoriteCompaniesSize; j++) {
            if (i != j && isSubset(favoriteCompanies[i], favoriteCompaniesColSize[i], favoriteCompanies[j], favoriteCompaniesColSize[j])) {
                isSubsetOfAnother = 1;
                break;
            }
        }
        if (!isSubsetOfAnother) {
            result[(*returnSize)++] = i;
        }
    }

    return realloc(result, (*returnSize) * sizeof(int));
}