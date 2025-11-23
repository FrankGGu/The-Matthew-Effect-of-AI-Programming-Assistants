#include <stdlib.h>
#include <string.h>

char** stringMatching(char** words, int wordsSize, int* returnSize) {
    *returnSize = 0;

    int capacity = 10; 
    char** result = (char**)malloc(capacity * sizeof(char*));

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < wordsSize; j++) {
            if (i == j) {
                continue;
            }

            if (strstr(words[j], words[i]) != NULL) {
                if (*returnSize == capacity) {
                    capacity *= 2;
                    result = (char**)realloc(result, capacity * sizeof(char*));
                }

                result[*returnSize] = (char*)malloc((strlen(words[i]) + 1) * sizeof(char));
                strcpy(result[*returnSize], words[i]);

                (*returnSize)++;

                break; 
            }
        }
    }

    if (*returnSize == 0) {
        free(result); 
        return NULL;  
    } else {
        return (char**)realloc(result, (*returnSize) * sizeof(char*));
    }
}