#include <stdlib.h>
#include <string.h>

char ** divideString(char * s, int k, char fill, int* returnSize) {
    int len = strlen(s);
    int num_groups = (len + k - 1) / k;

    char **result = (char **)malloc(num_groups * sizeof(char *));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < num_groups; i++) {
        result[i] = (char *)malloc((k + 1) * sizeof(char));
        if (result[i] == NULL) {
            // Cleanup previously allocated memory in case of failure
            for (int j = 0; j < i; j++) {
                free(result[j]);
            }
            free(result);
            *returnSize = 0;
            return NULL;
        }

        int current_s_idx = i * k;
        for (int j = 0; j < k; j++) {
            if (current_s_idx + j < len) {
                result[i][j] = s[current_s_idx + j];
            } else {
                result[i][j] = fill;
            }
        }
        result[i][k] = '\0';
    }

    *returnSize = num_groups;
    return result;
}