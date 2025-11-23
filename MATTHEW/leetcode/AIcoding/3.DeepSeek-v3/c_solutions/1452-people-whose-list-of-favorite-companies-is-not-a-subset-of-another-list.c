/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* peopleIndexes(char *** favoriteCompanies, int favoriteCompaniesSize, int* favoriteCompaniesColSize, int* returnSize) {
    int n = favoriteCompaniesSize;
    int** sets = (int**)malloc(n * sizeof(int*));
    int* setSizes = (int*)malloc(n * sizeof(int));

    // Create a mapping from company name to index
    int maxCompanies = 0;
    for (int i = 0; i < n; i++) {
        maxCompanies += favoriteCompaniesColSize[i];
    }

    char** allCompanies = (char**)malloc(maxCompanies * sizeof(char*));
    int companyCount = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < favoriteCompaniesColSize[i]; j++) {
            int found = 0;
            for (int k = 0; k < companyCount; k++) {
                if (strcmp(allCompanies[k], favoriteCompanies[i][j]) == 0) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                allCompanies[companyCount++] = favoriteCompanies[i][j];
            }
        }
    }

    // Create bitmask sets
    for (int i = 0; i < n; i++) {
        sets[i] = (int*)calloc(companyCount, sizeof(int));
        setSizes[i] = favoriteCompaniesColSize[i];
        for (int j = 0; j < favoriteCompaniesColSize[i]; j++) {
            for (int k = 0; k < companyCount; k++) {
                if (strcmp(allCompanies[k], favoriteCompanies[i][j]) == 0) {
                    sets[i][k] = 1;
                    break;
                }
            }
        }
    }

    int* result = (int*)malloc(n * sizeof(int));
    int count = 0;

    for (int i = 0; i < n; i++) {
        int isSubset = 0;
        for (int j = 0; j < n; j++) {
            if (i == j || setSizes[j] < setSizes[i]) continue;

            int subset = 1;
            for (int k = 0; k < companyCount; k++) {
                if (sets[i][k] && !sets[j][k]) {
                    subset = 0;
                    break;
                }
            }
            if (subset) {
                isSubset = 1;
                break;
            }
        }
        if (!isSubset) {
            result[count++] = i;
        }
    }

    for (int i = 0; i < n; i++) {
        free(sets[i]);
    }
    free(sets);
    free(setSizes);
    free(allCompanies);

    *returnSize = count;
    return result;
}