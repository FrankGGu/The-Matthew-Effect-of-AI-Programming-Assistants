#include <stdlib.h>
#include <string.h>

static int* parent;

static int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

static void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        parent[root_i] = root_j;
    }
}

static int compare_int(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

static int compare_char(const void* a, const void* b) {
    return (*(char*)a - *(char*)b);
}

typedef struct {
    int* indices;
    char* chars;
    int count;
    int capacity;
} ComponentData;

char* smallestStringWithSwaps(char* s, int** pairs, int pairsSize, int* pairsColSize) {
    int n = strlen(s);

    // Initialize DSU
    parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    // Process pairs to build connected components
    for (int i = 0; i < pairsSize; i++) {
        unite(pairs[i][0], pairs[i][1]);
    }

    // Allocate and initialize ComponentData for each possible root
    ComponentData* components = (ComponentData*)malloc(n * sizeof(ComponentData));
    for (int i = 0; i < n; i++) {
        components[i].indices = NULL;
        components[i].chars = NULL;
        components[i].count = 0;
        components[i].capacity = 0;
    }

    // Group indices and characters by their root parent
    for (int i = 0; i < n; i++) {
        int root = find(i); // Find the ultimate parent for current index i

        // Get the ComponentData for this root
        ComponentData* current_component = &components[root];

        // Check if capacity needs to be increased
        if (current_component->count == current_component->capacity) {
            int new_capacity = current_component->capacity == 0 ? 1 : current_component->capacity * 2;
            current_component->indices = (int*)realloc(current_component->indices, new_capacity * sizeof(int));
            current_component->chars = (char*)realloc(current_component->chars, new_capacity * sizeof(char));
            current_component->capacity = new_capacity;
        }

        // Add current index and character to the component
        current_component->indices[current_component->count] = i;
        current_component->chars[current_component->count] = s[i];
        current_component->count++;
    }

    // For each component, sort characters and indices, then place back into s
    for (int i = 0; i < n; i++) {
        ComponentData* current_component = &components[i];

        if (current_component->count > 0) {
            // Sort characters within this component
            qsort(current_component->chars, current_component->count, sizeof(char), compare_char);
            // Sort indices within this component
            qsort(current_component->indices, current_component->count, sizeof(int), compare_int);

            // Place sorted characters back into the original string at sorted indices
            for (int j = 0; j < current_component->count; j++) {
                s[current_component->indices[j]] = current_component->chars[j];
            }
        }
    }

    // Free allocated memory
    free(parent);
    for (int i = 0; i < n; i++) {
        if (components[i].indices != NULL) {
            free(components[i].indices);
        }
        if (components[i].chars != NULL) {
            free(components[i].chars);
        }
    }
    free(components);

    return s; // s is modified in-place
}