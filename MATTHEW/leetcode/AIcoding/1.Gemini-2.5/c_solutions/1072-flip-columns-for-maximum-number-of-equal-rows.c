#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For strcmp

int compareStrings(const void *a, const void *b) {
    const char *str1 = *(const char **)a;
    const char *str2 = *(const char **)b;
    return strcmp(str1, str2);
}

int maxEqualRowsAfterFlips(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0) {
        return 0;
    }

    int m = gridSize;
    int n = gridColSize[0];

    char** canonicalRows = (char**)malloc(m * sizeof(char*));
    if (canonicalRows == NULL) {
        return 0; 
    }

    for (int i = 0; i < m; ++i) {
        canonicalRows[i] = (char*)malloc((n + 1) * sizeof(char));
        if (canonicalRows[i] == NULL) {
            for (int k = 0; k < i; ++k) {
                free(canonicalRows[k]);
            }
            free(canonicalRows);
            return 0;
        }

        if (grid[i][0] == 1) {
            for (int j = 0; j < n; ++j) {
                canonicalRows[i][j] = (grid[i][j] == 1) ? '0' : '1';
            }
        } else { 
            for (int j = 0; j < n; ++j) {
                canonicalRows[i][j] = (grid[i][j] == 1) ? '1' : '0';
            }
        }
        canonicalRows[i][n] = '\0'; 
    }

    qsort(canonicalRows, m, sizeof(char*), compareStrings);

    int maxCount = 0;
    if (m > 0) {
        maxCount = 1; 
        int currentCount = 1;

        for (int i = 1; i < m; ++i) {
            if (strcmp(canonicalRows[i], canonicalRows[i-1]) == 0) {
                currentCount++;
            } else {
                if (currentCount > maxCount) {
                    maxCount = currentCount;
                }
                currentCount = 1;
            }
        }
        if (currentCount > maxCount) {
            maxCount = currentCount;
        }
    }

    for (int i = 0; i < m; ++i) {
        free(canonicalRows[i]);
    }
    free(canonicalRows);

    return maxCount;
}