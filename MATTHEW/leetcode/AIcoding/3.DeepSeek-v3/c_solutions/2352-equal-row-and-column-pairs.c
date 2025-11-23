typedef struct {
    int key[100];
    int count;
} RowKey;

typedef struct {
    RowKey* keys;
    int* counts;
    int size;
    int capacity;
} HashMap;

unsigned int hash(RowKey* key, int n) {
    unsigned int h = 0;
    for (int i = 0; i < n; i++) {
        h = h * 31 + key->key[i];
    }
    return h;
}

int compareKeys(RowKey* a, RowKey* b, int n) {
    for (int i = 0; i < n; i++) {
        if (a->key[i] != b->key[i]) {
            return 0;
        }
    }
    return 1;
}

void initHashMap(HashMap* map, int capacity) {
    map->keys = (RowKey*)malloc(capacity * sizeof(RowKey));
    map->counts = (int*)calloc(capacity, sizeof(int));
    map->size = 0;
    map->capacity = capacity;
}

void put(HashMap* map, RowKey* key, int n) {
    unsigned int index = hash(key, n) % map->capacity;

    while (map->counts[index] > 0) {
        if (compareKeys(&map->keys[index], key, n)) {
            map->counts[index]++;
            return;
        }
        index = (index + 1) % map->capacity;
    }

    for (int i = 0; i < n; i++) {
        map->keys[index].key[i] = key->key[i];
    }
    map->counts[index] = 1;
    map->size++;
}

int get(HashMap* map, RowKey* key, int n) {
    unsigned int index = hash(key, n) % map->capacity;

    while (map->counts[index] > 0) {
        if (compareKeys(&map->keys[index], key, n)) {
            return map->counts[index];
        }
        index = (index + 1) % map->capacity;
    }

    return 0;
}

int equalPairs(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    HashMap rowMap;
    initHashMap(&rowMap, n * 2);

    for (int i = 0; i < n; i++) {
        RowKey key;
        for (int j = 0; j < n; j++) {
            key.key[j] = grid[i][j];
        }
        put(&rowMap, &key, n);
    }

    int count = 0;
    for (int j = 0; j < n; j++) {
        RowKey key;
        for (int i = 0; i < n; i++) {
            key.key[i] = grid[i][j];
        }
        count += get(&rowMap, &key, n);
    }

    free(rowMap.keys);
    free(rowMap.counts);

    return count;
}