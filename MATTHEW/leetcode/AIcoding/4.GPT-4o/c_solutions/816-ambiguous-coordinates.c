#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** ambiguousCoordinates(char* S, int* returnSize) {
    int n = strlen(S) - 2;
    char** result = (char**)malloc(100 * sizeof(char*));
    *returnSize = 0;

    for (int i = 1; i < n; i++) {
        char* x = (char*)malloc((i + 2) * sizeof(char));
        char* y = (char*)malloc((n - i + 2) * sizeof(char));

        strncpy(x, S + 1, i);
        x[i] = '\0';
        strncpy(y, S + i + 1, n - i);
        y[n - i] = '\0';

        for (int j = 0; j <= i; j++) {
            for (int k = 0; k <= n - i; k++) {
                if (j == 0 && x[0] == '0' && x[1] != '\0') continue;
                if (j > 0 && x[j] == '0' && j < i) continue;

                if (k == 0 && y[0] == '0' && y[1] != '\0') continue;
                if (k > 0 && y[k] == '0' && k < n - i) continue;

                char* coord = (char*)malloc((strlen(x) + strlen(y) + 4) * sizeof(char));
                if (j < i) {
                    sprintf(coord, "(%.*s.%s, %.*s)", j, x, x + j, n - i - k, y);
                } else {
                    sprintf(coord, "(%s, %.*s.%s)", x, n - i - k, y, y + n - i - k);
                }
                result[(*returnSize)++] = coord;
            }
        }
        free(x);
        free(y);
    }

    return result;
}