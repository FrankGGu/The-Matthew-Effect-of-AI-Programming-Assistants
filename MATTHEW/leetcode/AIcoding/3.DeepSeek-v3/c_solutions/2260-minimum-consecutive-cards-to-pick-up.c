typedef struct {
    int key;
    int value;
    UT_hash_handle hh;
} HashEntry;

int minimumCardPickup(int* cards, int cardsSize) {
    HashEntry *map = NULL, *entry;
    int minDistance = INT_MAX;

    for (int i = 0; i < cardsSize; i++) {
        HASH_FIND_INT(map, &cards[i], entry);
        if (entry != NULL) {
            minDistance = fmin(minDistance, i - entry->value + 1);
            entry->value = i;
        } else {
            entry = malloc(sizeof(HashEntry));
            entry->key = cards[i];
            entry->value = i;
            HASH_ADD_INT(map, key, entry);
        }
    }

    HashEntry *current, *tmp;
    HASH_ITER(hh, map, current, tmp) {
        HASH_DEL(map, current);
        free(current);
    }

    return minDistance == INT_MAX ? -1 : minDistance;
}