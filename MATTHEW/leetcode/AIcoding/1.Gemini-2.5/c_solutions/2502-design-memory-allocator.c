#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct {
    int n;
    int* mem;
} Allocator;

Allocator* allocatorCreate(int n) {
    Allocator* obj = (Allocator*)malloc(sizeof(Allocator));
    if (obj == NULL) {
        return NULL;
    }
    obj->n = n;
    obj->mem = (int*)malloc(sizeof(int) * n);
    if (obj->mem == NULL) {
        free(obj);
        return NULL;
    }
    memset(obj->mem, 0, sizeof(int) * n); // Initialize all memory units to 0 (free)
    return obj;
}

int allocatorAllocate(Allocator* obj, int size, int mID) {
    if (obj == NULL || obj->mem == NULL) {
        return -1;
    }

    for (int i = 0; i <= obj->n - size; ++i) {
        bool is_free_block = true;
        for (int j = 0; j < size; ++j) {
            if (obj->mem[i + j] != 0) {
                is_free_block = false;
                // Optimization: If a non-free unit is found,
                // jump the outer loop's index 'i' past this occupied block.
                // The outer loop will increment 'i' by 1, so we adjust accordingly.
                i = i + j;
                break;
            }
        }

        if (is_free_block) {
            for (int j = 0; j < size; ++j) {
                obj->mem[i + j] = mID;
            }
            return i; // Return the starting index of the allocated block
        }
    }

    return -1; // No suitable block found
}

int allocatorFree(Allocator* obj, int mID) {
    if (obj == NULL || obj->mem == NULL) {
        return 0;
    }

    int freed_count = 0;
    for (int i = 0; i < obj->n; ++i) {
        if (obj->mem[i] == mID) {
            obj->mem[i] = 0; // Mark as free
            freed_count++;
        }
    }
    return freed_count;
}

void allocatorDestroy(Allocator* obj) {
    if (obj == NULL) {
        return;
    }
    if (obj->mem != NULL) {
        free(obj->mem);
    }
    free(obj);
}