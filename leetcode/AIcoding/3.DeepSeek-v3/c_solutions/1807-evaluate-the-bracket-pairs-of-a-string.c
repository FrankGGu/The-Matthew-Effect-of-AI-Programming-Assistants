typedef struct {
    char* key;
    char* value;
} Pair;

char* evaluate(char* s, char*** knowledge, int knowledgeSize, int* knowledgeColSize) {
    Pair* map = (Pair*)malloc(knowledgeSize * sizeof(Pair));
    for (int i = 0; i < knowledgeSize; i++) {
        map[i].key = knowledge[i][0];
        map[i].value = knowledge[i][1];
    }

    int len = strlen(s);
    char* res = (char*)malloc((len * 2 + 1) * sizeof(char));
    int idx = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            int j = i + 1;
            while (s[j] != ')') j++;
            int keyLen = j - i - 1;
            char* key = (char*)malloc((keyLen + 1) * sizeof(char));
            strncpy(key, s + i + 1, keyLen);
            key[keyLen] = '\0';

            char* value = "?";
            for (int k = 0; k < knowledgeSize; k++) {
                if (strcmp(map[k].key, key) == 0) {
                    value = map[k].value;
                    break;
                }
            }

            int valueLen = strlen(value);
            strncpy(res + idx, value, valueLen);
            idx += valueLen;
            i = j;
            free(key);
        } else {
            res[idx++] = s[i];
        }
    }
    res[idx] = '\0';
    free(map);
    return res;
}