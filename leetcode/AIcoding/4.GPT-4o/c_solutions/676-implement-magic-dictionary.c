#define MAX_WORD_LEN 100
#define DICT_SIZE 1000

typedef struct {
    char words[DICT_SIZE][MAX_WORD_LEN];
    int count;
} MagicDictionary;

MagicDictionary* magicDictionaryCreate() {
    MagicDictionary* dict = (MagicDictionary*)malloc(sizeof(MagicDictionary));
    dict->count = 0;
    return dict;
}

void magicDictionaryBuildDict(MagicDictionary* obj, char** dict, int dictSize) {
    for (int i = 0; i < dictSize; i++) {
        strcpy(obj->words[obj->count++], dict[i]);
    }
}

int magicDictionarySearch(MagicDictionary* obj, char* searchWord) {
    for (int i = 0; i < obj->count; i++) {
        if (strlen(obj->words[i]) != strlen(searchWord)) continue;
        int diff = 0;
        for (int j = 0; j < strlen(searchWord); j++) {
            if (obj->words[i][j] != searchWord[j]) {
                diff++;
                if (diff > 1) break;
            }
        }
        if (diff == 1) return 1;
    }
    return 0;
}

void magicDictionaryFree(MagicDictionary* obj) {
    free(obj);
}