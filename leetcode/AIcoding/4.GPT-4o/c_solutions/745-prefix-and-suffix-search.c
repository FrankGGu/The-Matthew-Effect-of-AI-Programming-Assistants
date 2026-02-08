typedef struct {
    char **words;
    int size;
} WordFilter;

WordFilter* wordFilterCreate(char ** words, int wordsSize) {
    WordFilter *filter = (WordFilter *)malloc(sizeof(WordFilter));
    filter->words = words;
    filter->size = wordsSize;
    return filter;
}

int wordFilterF(WordFilter* obj, char * prefix, char * suffix) {
    int len = strlen(prefix);
    int len2 = strlen(suffix);
    for (int i = obj->size - 1; i >= 0; i--) {
        if (strncmp(obj->words[i], prefix, len) == 0 && 
            strcmp(obj->words[i] + (obj->words[i][len] == '\0' ? 0 : strlen(obj->words[i]) - len2), suffix) == 0) {
            return i;
        }
    }
    return -1;
}

void wordFilterFree(WordFilter* obj) {
    free(obj);
}