#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset, memcpy if needed, or just loops

#define INITIAL_STACK_ARRAY_SIZE 16
#define INITIAL_HEAP_SIZE 16

typedef struct {
    int* data;
    int size;
    int capacity;
} MinHeap;

void min_heap_init(MinHeap* heap, int initial_capacity) {
    heap->data = (int*)malloc(initial_capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = initial_capacity;
}

void min_heap_resize(MinHeap* heap) {
    heap->capacity *= 2;
    heap->data = (int*)realloc(heap->data, heap->capacity * sizeof(int));
}

void min_heap_insert(MinHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        min_heap_resize(heap);
    }
    heap->data[heap->size] = val;
    int current = heap->size;
    heap->size++;
    while (current > 0 && heap->data[current] < heap->data[(current - 1) / 2]) {
        int parent = (current - 1) / 2;
        int temp = heap->data[current];
        heap->data[current] = heap->data[parent];
        heap->data[parent] = temp;
        current = parent;
    }
}

int min_heap_extract_min(MinHeap* heap) {
    if (heap->size == 0) return -1;
    int min_val = heap->data[0];
    heap->size--;
    heap->data[0] = heap->data[heap->size];
    int current = 0;
    while (true) {
        int left_child = 2 * current + 1;
        int right_child = 2 * current + 2;
        int smallest = current;

        if (left_child < heap->size && heap->data[left_child] < heap->data[smallest]) {
            smallest = left_child;
        }
        if (right_child < heap->size && heap->data[right_child] < heap->data[smallest]) {
            smallest = right_child;
        }

        if (smallest != current) {
            int temp = heap->data[current];
            heap->data[current] = heap->data[smallest];
            heap->data[smallest] = temp;
            current = smallest;
        } else {
            break;
        }
    }
    return min_val;
}

int min_heap_peek_min(MinHeap* heap) {
    if (heap->size == 0) return -1;
    return heap->data[0];
}

bool min_heap_is_empty(MinHeap* heap) {
    return heap->size == 0;
}

void min_heap_free(MinHeap* heap) {
    free(heap->data);
}

typedef struct {
    int* data;
    int size;
    int capacity;
} MaxHeap;

void max_heap_init(MaxHeap* heap, int initial_capacity) {
    heap->data = (int*)malloc(initial_capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = initial_capacity;
}

void max_heap_resize(MaxHeap* heap) {
    heap->capacity *= 2;
    heap->data = (int*)realloc(heap->data, heap->capacity * sizeof(int));
}

void max_heap_insert(MaxHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        max_heap_resize(heap);
    }
    heap->data[heap->size] = val;
    int current = heap->size;
    heap->size++;
    while (current > 0 && heap->data[current] > heap->data[(current - 1) / 2]) {
        int parent = (current - 1) / 2;
        int temp = heap->data[current];
        heap->data[current] = heap->data[parent];
        heap->data[parent] = temp;
        current = parent;
    }
}

int max_heap_extract_max(MaxHeap* heap) {
    if (heap->size == 0) return -1;
    int max_val = heap->data[0];
    heap->size--;
    heap->data[0] = heap->data[heap->size];
    int current = 0;
    while (true) {
        int left_child = 2 * current + 1;
        int right_child = 2 * current + 2;
        int largest = current;

        if (left_child < heap->size && heap->data[left_child] > heap->data[largest]) {
            largest = left_child;
        }
        if (right_child < heap->size && heap->data[right_child] > heap->data[largest]) {
            largest = right_child;
        }

        if (largest != current) {
            int temp = heap->data[current];
            heap->data[current] = heap->data[largest];
            heap->data[largest] = temp;
            current = largest;
        } else {
            break;
        }
    }
    return max_val;
}

int max_heap_peek_max(MaxHeap* heap) {
    if (heap->size == 0) return -1;
    return heap->data[0];
}

bool max_heap_is_empty(MaxHeap* heap) {
    return heap->size == 0;
}

void max_heap_free(MaxHeap* heap) {
    free(heap->data);
}

typedef struct {
    int capacity;
    int** stacks;          // Array of pointers to actual plate stacks (int arrays)
    int* stack_sizes;      // Array storing current number of plates in each stack
    int allocated_stacks;  // Current allocated size of `stacks` and `stack_sizes` arrays

    MinHeap available_push_indices; // Stores indices of stacks that are not full
    MaxHeap non_empty_pop_indices;  // Stores indices of stacks that are not empty
    int max_stack_idx_ever_used;    // The highest index a stack has ever been instantiated at.
                                    // Used to determine the next new stack index when all existing are full.
} DinnerPlates;

void reallocate_stacks_if_needed(DinnerPlates* obj, int target_idx) {
    if (target_idx < obj->allocated_stacks) {
        return; // Enough space
    }

    int old_allocated_stacks = obj->allocated_stacks;
    int new_allocated_stacks = obj->allocated_stacks;
    while (target_idx >= new_allocated_stacks) {
        new_allocated_stacks *= 2;
    }
    if (new_allocated_stacks == 0) new_allocated_stacks = INITIAL_STACK_ARRAY_SIZE;

    obj->stacks = (int**)realloc(obj->stacks, new_allocated_stacks * sizeof(int*));
    obj->stack_sizes = (int*)realloc(obj->stack_sizes, new_allocated_stacks * sizeof(int));

    // Initialize new memory
    for (int i = old_allocated_stacks; i < new_allocated_stacks; ++i) {
        obj->stacks[i] = NULL; // Individual stacks are lazily allocated
        obj->stack_sizes[i] = 0;
    }

    obj->allocated_stacks = new_allocated_stacks;
}

DinnerPlates* dinnerPlatesCreate(int capacity) {
    DinnerPlates* obj = (DinnerPlates*)malloc(sizeof(DinnerPlates));
    obj->capacity = capacity;
    obj->allocated_stacks = INITIAL_STACK_ARRAY_SIZE;
    obj->stacks = (int**)calloc(obj->allocated_stacks, sizeof(int*)); // calloc initializes to NULL
    obj->stack_sizes = (int*)calloc(obj->allocated_stacks, sizeof(int)); // calloc initializes to 0

    min_heap_init(&obj->available_push_indices, INITIAL_HEAP_SIZE);
    max_heap_init(&obj->non_empty_pop_indices, INITIAL_HEAP_SIZE);
    obj->max_stack_idx_ever_used = -1; // No stacks used yet

    return obj;
}

void dinnerPlatesPush(DinnerPlates* obj, int val) {
    int target_idx;

    // Determine the target stack index for pushing
    if (min_heap_is_empty(&obj->available_push_indices)) {
        // No previously used stacks are available (all are full or never existed),
        // so use the next new stack index.
        target_idx = obj->max_stack_idx_ever_used + 1;
    } else {
        // Get the leftmost available stack from the min-heap
        target_idx = min_heap_peek_min(&obj->available_push_indices);
    }

    // Ensure `stacks` and `stack_sizes` arrays are large enough for `target_idx`
    reallocate_stacks_if_needed(obj, target_idx);

    // If the target_idx stack array itself is not yet allocated, allocate it
    if (obj->stacks[target_idx] == NULL) {
        obj->stacks[target_idx] = (int*)malloc(obj->capacity * sizeof(int));
    }

    // Push the plate
    obj->stacks[target_idx][obj->stack_sizes[target_idx]++] = val;

    // Update max_stack_idx_ever_used if this push extends the range of used stacks
    if (target_idx > obj->max_stack_idx_ever_used) {
        obj->max_stack_idx_ever_used = target_idx;
    }

    // If the stack is now full, remove its index from available_push_indices
    if (obj->stack_sizes[target_idx] == obj->capacity) {
        // This must be the min element in the heap, so extract it.
        min_heap_extract_min(&obj->available_push_indices);
    }

    // If the stack was empty and now has plates, add its index to non_empty_pop_indices
    if (obj->stack_sizes[target_idx] == 1) { // It just went from 0 to 1
        max_heap_insert(&obj->non_empty_pop_indices, target_idx);
    }
}

int dinnerPlatesPop(DinnerPlates* obj) {
    int target_idx = -1;

    // Find the rightmost non-empty stack by repeatedly peeking and removing empty stacks
    while (!max_heap_is_empty(&obj->non_empty_pop_indices)) {
        target_idx = max_heap_peek_max(&obj->non_empty_pop_indices);
        if (obj->stack_sizes[target_idx] > 0) {
            break; // Found a non-empty stack
        } else {
            // This stack became empty but its index wasn't removed from heap yet. Remove it.
            max_heap_extract_max(&obj->non_empty_pop_indices);
            target_idx = -1; // Reset for next iteration
        }
    }

    if (target_idx == -1) { // No non-empty stacks found
        return -1;
    }

    // Pop the plate
    int val = obj->stacks[target_idx][--obj->stack_sizes[target_idx]];

    // If this stack is now not full (it was full and now has one less plate),
    // add its index to available_push_indices.
    // This handles cases where a full stack is popped from, making it available for push.
    if (obj->stack_sizes[target_idx] == obj->capacity - 1) {
        min_heap_insert(&obj->available_push_indices, target_idx);
    }

    // If this stack becomes empty, remove its index from non_empty_pop_indices.
    // This must be the max element in the heap, so extract it.
    if (obj->stack_sizes[target_idx] == 0) {
        max_heap_extract_max(&obj->non_empty_pop_indices);
    }

    return val;
}

int dinnerPlatesPopAtStack(DinnerPlates* obj, int index) {
    // Check if the index is valid and the stack is not empty
    if (index < 0 || index >= obj->allocated_stacks || obj->stacks[index] == NULL || obj->stack_sizes[index] == 0) {
        return -1;
    }

    // Pop the plate
    int val = obj->stacks[index][--obj->stack_sizes[index]];

    // If this stack is now not full (it was full and now has one less plate),
    // add its index to available_push_indices.
    if (obj->stack_sizes[index] == obj->capacity - 1) {
        min_heap_insert(&obj->available_push_indices, index);
    }

    // If this stack becomes empty, its index will be lazily removed from non_empty_pop_indices
    // by the `dinnerPlatesPop` function's while loop.
    // We cannot efficiently remove an arbitrary element from a heap without its position,
    // so we rely on this lazy deletion.

    return val;
}

void dinnerPlatesFree(DinnerPlates* obj) {
    if (!obj) return;

    // Free individual stack arrays
    for (int i = 0; i < obj->allocated_stacks; ++i) {
        free(obj->stacks[i]);
    }
    // Free the array of stack pointers
    free(obj->stacks);
    // Free the array of stack sizes
    free(obj->stack_sizes);
    // Free the heaps
    min_heap_free(&obj->available_push_indices);
    max_heap_free(&obj->non_empty_pop_indices);
    // Free the DinnerPlates object itself
    free(obj);
}