#include <stdlib.h> // For malloc, free, rand, abs
#include <stdbool.h> // For bool type

typedef struct MapEntry {
    int key;
    int value;
    struct MapEntry* next;
} MapEntry;

typedef struct {
    int m;
    int n;
    int total_cells; // Total number of cells in the matrix (m * n)
    int curr_size;   // Number of currently available (0-valued) cells

    MapEntry** hash_table; // Array of pointers to MapEntry, representing hash buckets
    int hash_table_size;   // Size of the hash table array
} Solution;

static int hash(int key, int table_size) {
    return abs(key) % table_size;
}

static void map_put(Solution* obj, int key, int value) {
    int idx = hash(key, obj->hash_table_size);
    MapEntry* current = obj->hash_table[idx];
    while (current != NULL) {
        if (current->key == key) {
            current->value = value; // Key found, update its value
            return;
        }
        current = current->next;
    }
    // Key not found, create a new entry and add it to the head of the list
    MapEntry* new_entry = (MapEntry*)malloc(sizeof(MapEntry));
    new_entry->key = key;
    new_entry->value = value;
    new_entry->next = obj->hash_table[idx];
    obj->hash_table[idx] = new_entry;
}

static bool map_get(Solution* obj, int key, int* out_value) {
    int idx = hash(key, obj->hash_table_size);
    MapEntry* current = obj->hash_table[idx];
    while (current != NULL) {
        if (current->key == key) {
            *out_value = current->value;
            return true; // Key found
        }
        current = current->next;
    }
    return false; // Key not found
}

static void map_clear(Solution* obj) {
    for (int i = 0; i < obj->hash_table_size; ++i) {
        MapEntry* current = obj->hash_table[i];
        while (current != NULL) {
            MapEntry* temp = current;
            current = current->next;
            free(temp);
        }
        obj->hash_table[i] = NULL; // Reset the bucket pointer
    }
}

Solution* solutionCreate(int m, int n) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->m = m;
    obj->n = n;
    obj->total_cells = m * n;
    obj->curr_size = obj->total_cells;

    // Initialize hash table. A prime number for size is generally good.
    // Given at most 1000 flip calls, 2003 buckets provide a good load factor.
    obj->hash_table_size = 2003; 
    obj->hash_table = (MapEntry**)calloc(obj->hash_table_size, sizeof(MapEntry*)); // calloc initializes pointers to NULL

    return obj;
}

int* solutionFlip(Solution* obj) {
    // Generate a random index within the current range of available cells [0, curr_size - 1]
    int rand_idx = rand() % obj->curr_size;

    // Determine the actual 1D index of the cell that corresponds to `rand_idx`.
    // This is either `rand_idx` itself or a remapped value from the hash map.
    int actual_cell_idx_to_return;
    if (!map_get(obj, rand_idx, &actual_cell_idx_to_return)) {
        actual_cell_idx_to_return = rand_idx;
    }

    // Determine the actual 1D index of the cell that corresponds to the last available position (`curr_size - 1`).
    int last_available_cell_idx;
    if (!map_get(obj, obj->curr_size - 1, &last_available_cell_idx)) {
        last_available_cell_idx = obj->curr_size - 1;
    }

    // To simulate removal of `actual_cell_idx_to_return`, we conceptually move
    // `last_available_cell_idx` into the `rand_idx` position.
    // This means `rand_idx` will now point to `last_available_cell_idx`.
    map_put(obj, rand_idx, last_available_cell_idx);

    // Decrement the count of available cells.
    obj->curr_size--;

    // Convert the 1D index of the flipped cell to 2D coordinates [row, col].
    int* coords = (int*)malloc(sizeof(int) * 2);
    coords[0] = actual_cell_idx_to_return / obj->n; // row = 1D_index / n
    coords[1] = actual_cell_idx_to_return % obj->n; // col = 1D_index % n

    return coords;
}

void solutionReset(Solution* obj) {
    // Clear all entries from the hash map, effectively un-flipping all cells.
    map_clear(obj);
    // Reset the count of available cells to the total number of cells.
    obj->curr_size = obj->total_cells;
}

void solutionFree(Solution* obj) {
    // Free all map entries.
    map_clear(obj);
    // Free the hash table array itself.
    free(obj->hash_table);
    // Free the Solution object.
    free(obj);
}