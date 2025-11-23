#include <stdlib.h>
#include <string.h>

char*** splitWordsBySeparator(char** words, int wordsSize, char separator, int* returnSize) {
    char** result = (char**)malloc(10 * sizeof(char*));
    int currentCapacity = 10;
    int currentSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        char* start = word;
        char* current = word;

        while (*current != '\0') {
            if (*current == separator) {
                if (current > start) {
                    int tokenLength = current - start;
                    char* token = (char*)malloc((tokenLength + 1) * sizeof(char));
                    strncpy(token, start, tokenLength);
                    token[tokenLength] = '\0';

                    if (currentSize == currentCapacity) {
                        currentCapacity *= 2;
                        result = (char**)realloc(result, currentCapacity * sizeof(char*));
                    }
                    result[currentSize++] = token;
                }
                start = current + 1;
            }
            current++;
        }

        if (current > start) {
            int tokenLength = current - start;
            char* token = (char*)malloc((tokenLength + 1) * sizeof(char));
            strncpy(token, start, tokenLength);
            token[tokenLength] = '\0';

            if (currentSize == currentCapacity) {
                currentCapacity *= 2;
                result = (char**)realloc(result, currentCapacity * sizeof(char*));
            }
            result[currentSize++] = token;
        }
    }

    *returnSize = currentSize;
    result = (char**)realloc(result, currentSize * sizeof(char*));
    return result;
}