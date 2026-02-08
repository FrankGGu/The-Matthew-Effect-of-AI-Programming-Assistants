typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} Map;

int numberOfSpecialChars(char* word) {
    Map *seen = NULL;
    Map *lastOccurrenceLower = NULL;
    Map *firstOccurrenceUpper = NULL;

    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        char c = word[i];
        Map *entry;
        HASH_FIND_INT(seen, &c, entry);
        if (entry == NULL) {
            entry = (Map*)malloc(sizeof(Map));
            entry->key = c;
            entry->val = i;
            HASH_ADD_INT(seen, key, entry);
        }

        if (c >= 'a' && c <= 'z') {
            Map *lowerEntry;
            HASH_FIND_INT(lastOccurrenceLower, &c, lowerEntry);
            if (lowerEntry == NULL) {
                lowerEntry = (Map*)malloc(sizeof(Map));
                lowerEntry->key = c;
                lowerEntry->val = i;
                HASH_ADD_INT(lastOccurrenceLower, key, lowerEntry);
            } else {
                lowerEntry->val = i;
            }
        } else {
            Map *upperEntry;
            int upperKey = c;
            HASH_FIND_INT(firstOccurrenceUpper, &upperKey, upperEntry);
            if (upperEntry == NULL) {
                upperEntry = (Map*)malloc(sizeof(Map));
                upperEntry->key = c;
                upperEntry->val = i;
                HASH_ADD_INT(firstOccurrenceUpper, key, upperEntry);
            }
        }
    }

    int count = 0;
    for (char c = 'a'; c <= 'z'; c++) {
        Map *lowerEntry;
        HASH_FIND_INT(lastOccurrenceLower, &c, lowerEntry);

        char upper = c - 'a' + 'A';
        Map *upperEntry;
        HASH_FIND_INT(firstOccurrenceUpper, &upper, upperEntry);

        if (lowerEntry != NULL && upperEntry != NULL) {
            if (lowerEntry->val < upperEntry->val) {
                count++;
            }
        }
    }

    Map *current, *tmp;
    HASH_ITER(hh, seen, current, tmp) {
        HASH_DEL(seen, current);
        free(current);
    }
    HASH_ITER(hh, lastOccurrenceLower, current, tmp) {
        HASH_DEL(lastOccurrenceLower, current);
        free(current);
    }
    HASH_ITER(hh, firstOccurrenceUpper, current, tmp) {
        HASH_DEL(firstOccurrenceUpper, current);
        free(current);
    }

    return count;
}