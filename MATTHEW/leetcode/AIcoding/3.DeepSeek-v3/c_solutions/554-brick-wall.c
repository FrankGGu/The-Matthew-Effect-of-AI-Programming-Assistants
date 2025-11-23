typedef struct {
    int key;
    int count;
    UT_hash_handle hh;
} HashEntry;

int leastBricks(int** wall, int wallSize, int* wallColSize) {
    HashEntry *hash = NULL, *entry = NULL;
    int max_count = 0;

    for (int i = 0; i < wallSize; i++) {
        int sum = 0;
        for (int j = 0; j < wallColSize[i] - 1; j++) {
            sum += wall[i][j];
            HASH_FIND_INT(hash, &sum, entry);
            if (entry == NULL) {
                entry = (HashEntry*)malloc(sizeof(HashEntry));
                entry->key = sum;
                entry->count = 1;
                HASH_ADD_INT(hash, key, entry);
            } else {
                entry->count++;
            }
            if (entry->count > max_count) {
                max_count = entry->count;
            }
        }
    }

    HashEntry *tmp;
    HASH_ITER(hh, hash, entry, tmp) {
        HASH_DEL(hash, entry);
        free(entry);
    }

    return wallSize - max_count;
}