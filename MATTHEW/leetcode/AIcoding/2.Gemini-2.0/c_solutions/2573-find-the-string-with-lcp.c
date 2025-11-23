#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *findTheString(int **lcp, int n) {
    char *result = (char *)malloc((n + 1) * sizeof(char));
    if (result == NULL) {
        return NULL;
    }
    result[n] = '\0';

    char current_char = 'a';
    char mapping[26] = {0};

    for (int i = 0; i < n; i++) {
        if (mapping[i] == 0) {
            mapping[i] = current_char++;
        }
        result[i] = mapping[i];
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int expected_lcp;
            if (result[i] == result[j]) {
                if (i + 1 < n && j + 1 < n) {
                    expected_lcp = lcp[i + 1][j + 1] + 1;
                } else {
                    expected_lcp = 1;
                }
            } else {
                expected_lcp = 0;
            }

            if (lcp[i][j] != expected_lcp) {
                free(result);
                return "";
            }
        }
    }

    return result;
}