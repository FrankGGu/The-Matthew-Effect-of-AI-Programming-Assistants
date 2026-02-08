char* findReplaceString(char* S, int* indexes, int indexesSize, char** sources, char** targets, int targetsSize, int* returnSize) {
    int n = strlen(S);
    bool* to_replace = (bool*)malloc(n * sizeof(bool));
    char* result = (char*)malloc(2 * n * sizeof(char));
    *returnSize = 0;

    for (int i = 0; i < indexesSize; i++) {
        int idx = indexes[i];
        if (idx + strlen(sources[i]) <= n && strncmp(S + idx, sources[i], strlen(sources[i])) == 0) {
            to_replace[idx] = true;
        }
    }

    int pos = 0;
    for (int i = 0; i < n; i++) {
        if (to_replace[i]) {
            int idx = -1;
            for (int j = 0; j < indexesSize; j++) {
                if (indexes[j] == i) {
                    idx = j;
                    break;
                }
            }
            if (idx != -1) {
                strcpy(result + pos, targets[idx]);
                pos += strlen(targets[idx]);
                i += strlen(sources[idx]) - 1;
            }
        } else {
            result[pos++] = S[i];
        }
    }
    result[pos] = '\0';
    *returnSize = pos;

    free(to_replace);
    return result;
}