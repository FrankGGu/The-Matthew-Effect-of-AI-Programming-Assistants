#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define HASH_CAPACITY 65537 // A prime number for hash table capacity

typedef struct {
    int key;
    int value;
    bool occupied; // True if this slot is occupied
} IntMapEntry;

typedef struct {
    IntMapEntry* entries;
    int capacity;
    int size; // Number of actual entries
} IntHashMap;

void initIntHashMap(IntHashMap* map) {
    map->capacity = HASH_CAPACITY;
    map->entries = (IntMapEntry*)calloc(map->capacity, sizeof(IntMapEntry));
    map->size = 0;
}

void freeIntHashMap(IntHashMap* map) {
    free(map->entries);
    map->entries = NULL;
}

static unsigned int hashInt(int key, int capacity) {
    return (unsigned int)(key * 2654435761U) % capacity;
}

int getIntHashMap(IntHashMap* map, int key) {
    unsigned int index = hashInt(key, map->capacity);
    while (map->entries[index].occupied) {
        if (map->entries[index].key == key) {
            return map->entries[index].value;
        }
        index = (index + 1) % map->capacity; // Linear probing
    }
    return 0; // Key not found
}

void putIntHashMap(IntHashMap* map, int key, int value) {
    unsigned int index = hashInt(key, map->capacity);
    while (map->entries[index].occupied && map->entries[index].key != key) {
        index = (index + 1) % map->capacity; // Linear probing
    }
    if (!map->entries[index].occupied) {
        map->entries[index].occupied = true;
        map->entries[index].key = key;
        map->size++;
    }
    map->entries[index].value = value;
}

typedef struct {
    long long key; // Encoded as (long long)row << 32 | col
    bool value;    // True if lamp is active
    bool occupied;
} LampMapEntry;

typedef struct {
    LampMapEntry* entries;
    int capacity;
    int size;
} LampHashMap;

void initLampHashMap(LampHashMap* map) {
    map->capacity = HASH_CAPACITY;
    map->entries = (LampMapEntry*)calloc(map->capacity, sizeof(LampMapEntry));
    map->size = 0;
}

void freeLampHashMap(LampHashMap* map) {
    free(map->entries);
    map->entries = NULL;
}

static unsigned int hashLong(long long key, int capacity) {
    return (unsigned int)((key ^ (key >> 32)) * 2654435761U) % capacity;
}

bool getLampHashMap(LampHashMap* map, long long key) {
    unsigned int index = hashLong(key, map->capacity);
    while (map->entries[index].occupied) {
        if (map->entries[index].key == key) {
            return map->entries[index].value;
        }
        index = (index + 1) % map->capacity;
    }
    return false; // Key not found
}

void putLampHashMap(LampHashMap* map, long long key, bool value) {
    unsigned int index = hashLong(key, map->capacity);
    while (map->entries[index].occupied && map->entries[index].key != key) {
        index = (index + 1) % map->capacity;
    }
    if (!map->entries[index].occupied) {
        map->entries[index].occupied = true;
        map->entries[index].key = key;
        map->size++;
    }
    map->entries[index].value = value;
}

int* gridIllumination(int n, int** lamps, int lampsSize, int* lampsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    IntHashMap row_counts, col_counts, diag1_counts, diag2_counts;
    LampHashMap active_lamps;

    initIntHashMap(&row_counts);
    initIntHashMap(&col_counts);
    initIntHashMap(&diag1_counts);
    initIntHashMap(&diag2_counts);
    initLampHashMap(&active_lamps);

    for (int i = 0; i < lampsSize; i++) {
        int r = lamps[i][0];
        int c = lamps[i][1];
        long long lamp_key = ((long long)r << 32) | c;

        if (!getLampHashMap(&active_lamps, lamp_key)) {
            putLampHashMap(&active_lamps, lamp_key, true);
            putIntHashMap(&row_counts, r, getIntHashMap(&row_counts, r) + 1);
            putIntHashMap(&col_counts, c, getIntHashMap(&col_counts, c) + 1);
            putIntHashMap(&diag1_counts, r - c, getIntHashMap(&diag1_counts, r - c) + 1);
            putIntHashMap(&diag2_counts, r + c, getIntHashMap(&diag2_counts, r + c) + 1);
        }
    }

    int* results = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int dr[] = {-1, -1, -1, 0, 0, 0, 1, 1, 1};
    int dc[] = {-1, 0, 1, -1, 0, 1, -1, 0, 1};

    for (int i = 0; i < queriesSize; i++) {
        int qr = queries[i][0];
        int qc = queries[i][1];

        if (getIntHashMap(&row_counts, qr) > 0 ||
            getIntHashMap(&col_counts, qc) > 0 ||
            getIntHashMap(&diag1_counts, qr - qc) > 0 ||
            getIntHashMap(&diag2_counts, qr + qc) > 0) {
            results[i] = 1;
        } else {
            results[i] = 0;
        }

        for (int k = 0; k < 9; k++) {
            int nr = qr + dr[k];
            int nc = qc + dc[k];

            if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                long long adjacent_lamp_key = ((long long)nr << 32) | nc;
                if (getLampHashMap(&active_lamps, adjacent_lamp_key)) {
                    putLampHashMap(&active_lamps, adjacent_lamp_key, false);

                    putIntHashMap(&row_counts, nr, getIntHashMap(&row_counts, nr) - 1);
                    putIntHashMap(&col_counts, nc, getIntHashMap(&col_counts, nc) - 1);
                    putIntHashMap(&diag1_counts, nr - nc, getIntHashMap(&diag1_counts, nr - nc) - 1);
                    putIntHashMap(&diag2_counts, nr + nc, getIntHashMap(&diag2_counts, nr + nc) - 1);
                }
            }
        }
    }

    freeIntHashMap(&row_counts);
    freeIntHashMap(&col_counts);
    freeIntHashMap(&diag1_counts);
    freeIntHashMap(&diag2_counts);
    freeLampHashMap(&active_lamps);

    return results;
}