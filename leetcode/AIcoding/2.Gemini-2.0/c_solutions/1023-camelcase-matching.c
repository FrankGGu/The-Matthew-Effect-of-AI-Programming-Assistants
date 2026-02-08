#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool* camelMatch(char** queries, int queriesSize, char* pattern, int* returnSize) {
    *returnSize = queriesSize;
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        char* query = queries[i];
        int pattern_index = 0;
        bool match = true;
        for (int j = 0; query[j] != '\0'; j++) {
            if (pattern_index < strlen(pattern) && query[j] == pattern[pattern_index]) {
                pattern_index++;
            } else if (query[j] >= 'A' && query[j] <= 'Z') {
                match = false;
                break;
            }
        }
        if (match && pattern_index == strlen(pattern)) {
            result[i] = true;
        } else {
            result[i] = false;
        }
    }
    return result;
}