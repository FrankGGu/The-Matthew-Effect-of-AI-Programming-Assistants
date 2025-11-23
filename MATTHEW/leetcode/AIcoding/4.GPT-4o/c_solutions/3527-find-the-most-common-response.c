#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* response;
    int count;
} ResponseCount;

int cmp(const void* a, const void* b) {
    ResponseCount* respA = (ResponseCount*)a;
    ResponseCount* respB = (ResponseCount*)b;
    return respB->count - respA->count;
}

char* mostCommonResponse(char** responses, int responsesSize) {
    if (responsesSize == 0) return "";

    ResponseCount* counts = malloc(sizeof(ResponseCount) * responsesSize);
    int uniqueCount = 0;

    for (int i = 0; i < responsesSize; i++) {
        int found = 0;
        for (int j = 0; j < uniqueCount; j++) {
            if (strcmp(counts[j].response, responses[i]) == 0) {
                counts[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            counts[uniqueCount].response = responses[i];
            counts[uniqueCount].count = 1;
            uniqueCount++;
        }
    }

    qsort(counts, uniqueCount, sizeof(ResponseCount), cmp);
    char* result = counts[0].response;
    free(counts);
    return result;
}