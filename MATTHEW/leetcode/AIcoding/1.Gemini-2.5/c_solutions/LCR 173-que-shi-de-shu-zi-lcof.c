#include <stdlib.h>
#include <string.h>

int compareStrings(const void* a, const void* b) {
    const char* s1 = *(const char**)a;
    const char* s2 = *(const char**)b;
    return strcmp(s1, s2);
}

char** rollCall(char** names, int namesSize, int* returnSize) {
    if (namesSize <= 1) {
        *returnSize = 0;
        return NULL;
    }

    qsort(names, namesSize, sizeof(char*), compareStrings);

    char** result = (char**)malloc(namesSize * sizeof(char*));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int k = 0; 

    for (int i = 0; i < namesSize; ) {
        int j = i;
        while (j < namesSize && strcmp(names[i], names[j]) == 0) {
            j++;
        }

        if (j - i > 1) {
            size_t len = strlen(names[i]);
            result[k] = (char*)malloc((len + 1) * sizeof(char));
            if (result[k] == NULL) {
                for (int l = 0; l < k; ++l) {
                    free(result[l]);
                }
                free(result);
                *returnSize = 0;
                return NULL;
            }
            strcpy(result[k], names[i]);
            k++;
        }

        i = j;
    }

    *returnSize = k;

    if (k == 0) {
        free(result);
        return NULL;
    } else {
        char** finalResult = (char**)realloc(result, k * sizeof(char*));
        if (finalResult != NULL) {
            return finalResult;
        } else {
            return result; 
        }
    }
}