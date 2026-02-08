typedef struct {
    char* key;
    int count;
    UT_hash_handle hh;
} HashEntry;

int maxFreq(char* s, int maxLetters, int minSize, int maxSize) {
    HashEntry* map = NULL;
    int len = strlen(s);
    int maxCount = 0;

    for (int size = minSize; size <= maxSize; size++) {
        int letters[26] = {0};
        int unique = 0;

        for (int i = 0; i < size; i++) {
            if (letters[s[i] - 'a'] == 0) {
                unique++;
            }
            letters[s[i] - 'a']++;
        }

        if (unique <= maxLetters) {
            char* substr = (char*)malloc(size + 1);
            strncpy(substr, s, size);
            substr[size] = '\0';

            HashEntry* entry = NULL;
            HASH_FIND_STR(map, substr, entry);
            if (entry == NULL) {
                entry = (HashEntry*)malloc(sizeof(HashEntry));
                entry->key = substr;
                entry->count = 1;
                HASH_ADD_KEYPTR(hh, map, entry->key, size, entry);
            } else {
                entry->count++;
                free(substr);
            }

            if (entry->count > maxCount) {
                maxCount = entry->count;
            }
        }

        for (int i = size; i < len; i++) {
            if (letters[s[i - size] - 'a'] == 1) {
                unique--;
            }
            letters[s[i - size] - 'a']--;

            if (letters[s[i] - 'a'] == 0) {
                unique++;
            }
            letters[s[i] - 'a']++;

            if (unique <= maxLetters) {
                char* substr = (char*)malloc(size + 1);
                strncpy(substr, s + i - size + 1, size);
                substr[size] = '\0';

                HashEntry* entry = NULL;
                HASH_FIND_STR(map, substr, entry);
                if (entry == NULL) {
                    entry = (HashEntry*)malloc(sizeof(HashEntry));
                    entry->key = substr;
                    entry->count = 1;
                    HASH_ADD_KEYPTR(hh, map, entry->key, size, entry);
                } else {
                    entry->count++;
                    free(substr);
                }

                if (entry->count > maxCount) {
                    maxCount = entry->count;
                }
            }
        }
    }

    HashEntry *current, *tmp;
    HASH_ITER(hh, map, current, tmp) {
        HASH_DEL(map, current);
        free(current->key);
        free(current);
    }

    return maxCount;
}