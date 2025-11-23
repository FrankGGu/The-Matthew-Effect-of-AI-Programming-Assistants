typedef struct {
    char** words;
    int size;
} WordList;

typedef struct {
    char* key;
    int count;
    UT_hash_handle hh;
} CharMap;

long long distinctNames(char** ideas, int ideasSize) {
    WordList groups[26];
    for (int i = 0; i < 26; i++) {
        groups[i].words = NULL;
        groups[i].size = 0;
    }

    for (int i = 0; i < ideasSize; i++) {
        int idx = ideas[i][0] - 'a';
        groups[idx].size++;
        groups[idx].words = realloc(groups[idx].words, groups[idx].size * sizeof(char*));
        groups[idx].words[groups[idx].size - 1] = ideas[i] + 1;
    }

    CharMap* maps[26] = {NULL};
    for (int i = 0; i < 26; i++) {
        if (groups[i].size == 0) continue;

        CharMap* map = NULL;
        for (int j = 0; j < groups[i].size; j++) {
            CharMap* entry;
            HASH_FIND_STR(map, groups[i].words[j], entry);
            if (!entry) {
                entry = malloc(sizeof(CharMap));
                entry->key = groups[i].words[j];
                entry->count = 1;
                HASH_ADD_KEYPTR(hh, map, entry->key, strlen(entry->key), entry);
            } else {
                entry->count++;
            }
        }
        maps[i] = map;
    }

    long long res = 0;
    for (int i = 0; i < 26; i++) {
        if (groups[i].size == 0) continue;
        for (int j = i + 1; j < 26; j++) {
            if (groups[j].size == 0) continue;

            int mutual = 0;
            CharMap* map1 = maps[i];
            CharMap* map2 = maps[j];

            CharMap *el1, *tmp1;
            HASH_ITER(hh, map1, el1, tmp1) {
                CharMap* found;
                HASH_FIND_STR(map2, el1->key, found);
                if (found) {
                    mutual++;
                }
            }

            res += (long long)(groups[i].size - mutual) * (groups[j].size - mutual) * 2;
        }
    }

    for (int i = 0; i < 26; i++) {
        CharMap *el, *tmp;
        HASH_ITER(hh, maps[i], el, tmp) {
            HASH_DEL(maps[i], el);
            free(el);
        }
        free(groups[i].words);
    }

    return res;
}