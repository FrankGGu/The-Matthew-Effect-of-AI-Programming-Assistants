/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
bool match(char* query, char* pattern) {
    int i = 0, j = 0;
    while (query[i] != '\0') {
        if (pattern[j] != '\0' && query[i] == pattern[j]) {
            j++;
        } else if (query[i] >= 'A' && query[i] <= 'Z') {
            return false;
        }
        i++;
    }
    return pattern[j] == '\0';
}

bool* camelMatch(char** queries, int queriesSize, char* pattern, int* returnSize) {
    *returnSize = queriesSize;
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = match(queries[i], pattern);
    }
    return result;
}