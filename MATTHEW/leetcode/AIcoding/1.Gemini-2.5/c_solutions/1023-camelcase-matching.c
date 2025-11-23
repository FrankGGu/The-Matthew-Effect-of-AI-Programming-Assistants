#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>

static bool isMatch(char* query, char* pattern) {
    int i = 0;
    int j = 0;

    while (query[i] != '\0') {
        if (pattern[j] != '\0' && query[i] == pattern[j]) {
            j++;
        } else if (isupper(query[i])) {
            return false;
        }
        i++;
    }

    return pattern[j] == '\0';
}

bool* camelMatch(char** queries, int queriesSize, char* pattern, int* returnSize) {
    bool* result = (bool*)malloc(sizeof(bool) * queriesSize);
    *returnSize = queriesSize;

    for (int k = 0; k < queriesSize; k++) {
        result[k] = isMatch(queries[k], pattern);
    }

    return result;
}