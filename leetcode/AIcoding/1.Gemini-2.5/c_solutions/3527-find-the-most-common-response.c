#include <stdlib.h>
#include <string.h>

int compareStrings(const void* a, const void* b) {
    const char* strA = *(const char**)a;
    const char* strB = *(const char**)b;
    return strcmp(strA, strB);
}

char* findMostCommonResponse(char** responses, int responsesSize) {
    if (responsesSize == 0) {
        return NULL;
    }

    qsort(responses, responsesSize, sizeof(char*), compareStrings);

    int maxCount = 0;
    char* mostCommonResponse = NULL;

    int i = 0;
    while (i < responsesSize) {
        char* currentResponse = responses[i];
        int currentCount = 0;
        int j = i;
        while (j < responsesSize && strcmp(responses[j], currentResponse) == 0) {
            currentCount++;
            j++;
        }

        if (currentCount > maxCount) {
            maxCount = currentCount;
            if (mostCommonResponse != NULL) {
                free(mostCommonResponse);
            }
            mostCommonResponse = (char*)malloc(strlen(currentResponse) + 1);
            strcpy(mostCommonResponse, currentResponse);
        }
        i = j;
    }

    return mostCommonResponse;
}