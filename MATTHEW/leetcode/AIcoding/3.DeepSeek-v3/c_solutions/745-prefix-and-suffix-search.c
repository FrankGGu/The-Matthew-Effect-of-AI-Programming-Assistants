typedef struct {
    char** words;
    int wordsSize;
} WordFilter;

WordFilter* wordFilterCreate(char** words, int wordsSize) {
    WordFilter* obj = (WordFilter*)malloc(sizeof(WordFilter));
    obj->words = words;
    obj->wordsSize = wordsSize;
    return obj;
}

int wordFilterF(WordFilter* obj, char* pref, char* suff) {
    int prefLen = strlen(pref);
    int suffLen = strlen(suff);

    for (int i = obj->wordsSize - 1; i >= 0; i--) {
        char* word = obj->words[i];
        int wordLen = strlen(word);

        if (wordLen < prefLen || wordLen < suffLen) {
            continue;
        }

        int prefixMatch = 1;
        for (int j = 0; j < prefLen; j++) {
            if (word[j] != pref[j]) {
                prefixMatch = 0;
                break;
            }
        }

        if (!prefixMatch) {
            continue;
        }

        int suffixMatch = 1;
        for (int j = 0; j < suffLen; j++) {
            if (word[wordLen - suffLen + j] != suff[j]) {
                suffixMatch = 0;
                break;
            }
        }

        if (suffixMatch) {
            return i;
        }
    }

    return -1;
}

void wordFilterFree(WordFilter* obj) {
    free(obj);
}