typedef struct {
    int index;
    char* source;
    char* target;
} Operation;

int cmp(const void* a, const void* b) {
    return ((Operation*)a)->index - ((Operation*)b)->index;
}

char* findReplaceString(char* s, int* indices, int indicesSize, char** sources, int sourcesSize, char** targets, int targetsSize) {
    Operation ops[indicesSize];
    for (int i = 0; i < indicesSize; i++) {
        ops[i].index = indices[i];
        ops[i].source = sources[i];
        ops[i].target = targets[i];
    }

    qsort(ops, indicesSize, sizeof(Operation), cmp);

    char* result = (char*)malloc(1000 * sizeof(char));
    int resultLen = 0;
    int pos = 0;

    for (int i = 0; i < indicesSize; i++) {
        int idx = ops[i].index;
        char* src = ops[i].source;
        char* tar = ops[i].target;
        int srcLen = strlen(src);

        while (pos < idx) {
            result[resultLen++] = s[pos++];
        }

        if (strncmp(s + idx, src, srcLen) == 0) {
            int tarLen = strlen(tar);
            for (int j = 0; j < tarLen; j++) {
                result[resultLen++] = tar[j];
            }
            pos += srcLen;
        }
    }

    while (s[pos] != '\0') {
        result[resultLen++] = s[pos++];
    }

    result[resultLen] = '\0';
    return result;
}