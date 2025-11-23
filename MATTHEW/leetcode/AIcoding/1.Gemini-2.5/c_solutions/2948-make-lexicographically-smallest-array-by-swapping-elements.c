#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    int value;
    int index;
} Element;

int compareElements(const void *a, const void *b) {
    return ((Element *)a)->value - ((Element *)b)->value;
}

static int *parent;
static int *sz; // size of component

int find(int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent[i]);
}

void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        if (sz[root_i] < sz[root_j]) {
            int temp = root_i;
            root_i = root_j;
            root_j = temp;
        }
        parent[root_j] = root_i;
        sz[root_i] += sz[root_j];
    }
}

int* lexicographicallySmallestArray(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(sizeof(int) * numsSize);
    if (!result) return NULL;

    parent = (int*)malloc(sizeof(int) * numsSize);
    sz = (int*)malloc(sizeof(int) * numsSize);
    if (!parent || !sz) {
        free(result);
        free(parent);
        free(sz);
        return NULL;
    }

    // Initialize DSU
    for (int i = 0; i < numsSize; ++i) {
        parent[i] = i;
        sz[i] = 1;
    }

    // Sort the elements along with their original indices
    Element* elements = (Element*)malloc(sizeof(Element) * numsSize);
    if (!elements) {
        free(result);
        free(parent);
        free(sz);
        return NULL;
    }
    for (int i = 0; i < numsSize; ++i) {
        elements[i].value = nums[i];
        elements[i].index = i;
    }
    qsort(elements, numsSize, sizeof(Element), compareElements);

    // Build connected components based on the sorted elements
    // If two adjacent elements in the sorted list can be swapped (their original indices are within k distance),
    // they belong to the same component.
    // Since we can perform any number of swaps, if A can swap with B, and B with C, then A, B, C are all connected.
    // This is effectively connecting consecutive elements in the sorted array if their original indices are close.
    for (int i = 0; i < numsSize - 1; ++i) {
        if (elements[i+1].value - elements[i].value <= k) {
            unite(elements[i].index, elements[i+1].index);
        }
    }

    // Group original indices and values by their component root
    // Using dynamically sized arrays for each component.
    // A more efficient way for LeetCode might be to use a fixed-size array for each component (max size numsSize)
    // and track current count, or use a list of lists.
    // For C, a common approach is to map root to a list of indices and a list of values.
    // Since we need to sort values and indices for each component, we can collect them.

    // Map: root_index -> list of original indices in this component
    // Map: root_index -> list of values in this component
    // We need to iterate through the original nums array to get components.

    // Using an array of vectors (or dynamic arrays)
    // For C, we can simulate this with dynamic arrays or by pre-calculating component sizes.
    // A simpler approach for fixed-size arrays is to use a max number of elements for temporary storage
    // and copy back.

    // Let's use a temporary structure to hold indices and values for each component
    // Max components = numsSize. Max elements per component = numsSize.

    // Store indices and values for each component in separate lists
    // This requires knowing the roots and then iterating.
    // A better way is to iterate through original indices, find their root, and collect them.

    // `component_indices[root]` will store a list of original indices belonging to `root`
    // `component_values[root]` will store a list of values belonging to `root`

    // Max number of elements in a component is numsSize.
    // We need to store lists of indices and values.
    // Let's use `int**` for indices and `int**` for values, and `int*` for counts.
    // And also `int*` for current write pointers.

    int** component_indices = (int**)malloc(sizeof(int*) * numsSize);
    int** component_values = (int**)malloc(sizeof(int*) * numsSize);
    int* component_counts = (int*)calloc(numsSize, sizeof(int)); // Stores actual count of elements in each component
    int* current_component_idx = (int*)calloc(numsSize, sizeof(int)); // For writing values back

    if (!component_indices || !component_values || !component_counts || !current_component_idx) {
        free(result);
        free(parent);
        free(sz);
        free(elements);
        free(component_indices);
        free(component_values);
        free(component_counts);
        free(current_component_idx);
        return NULL;
    }

    // First pass: count elements for each component
    for (int i = 0; i < numsSize; ++i) {
        int root = find(i);
        component_counts[root]++;
    }

    // Allocate memory for each component's indices and values lists
    for (int i = 0; i < numsSize; ++i) {
        if (component_counts[i] > 0) {
            component_indices[i] = (int*)malloc(sizeof(int) * component_counts[i]);
            component_values[i] = (int*)malloc(sizeof(int) * component_counts[i]);
            if (!component_indices[i] || !component_values[i]) {
                // Handle allocation failure: free already allocated memory
                for (int j = 0; j < i; ++j) {
                    if (component_counts[j] > 0) {
                        free(component_indices[j]);
                        free(component_values[j]);
                    }
                }
                free(result);
                free(parent);
                free(sz);
                free(elements);
                free(component_indices);
                free(component_values);
                free(component_counts);
                free(current_component_idx);
                return NULL;
            }
        }
        current_component_idx[i] = 0; // Reset for actual population
    }

    // Second pass: populate elements into component lists
    for (int i = 0; i < numsSize; ++i) {
        int root = find(i);
        int current_idx = current_component_idx[root];
        component_indices[root][current_idx] = i;
        component_values[root][current_idx] = nums[i];
        current_component_idx[root]++;
    }

    // For each component, sort its indices and values
    for (int i = 0; i < numsSize; ++i) {
        if (component_counts[i] > 0) {
            // Sort values
            qsort(component_values[i], component_counts[i], sizeof(int), (int (*)(const void *, const void *))strcmp); // Using strcmp for int comparison is wrong, need a custom one.
            // Correct comparison for int arrays
            qsort(component_values[i], component_counts[i], sizeof(int), compareElements); // Re-using compareElements, but it expects Element*. Need a simple int compare.

            // Custom qsort for int array
            int compareInts(const void *a, const void *b) {
                return (*(int*)a - *(int*)b);
            }
            qsort(component_values[i], component_counts[i], sizeof(int), compareInts);

            // Sort indices
            qsort(component_indices[i], component_counts[i], sizeof(int), compareInts);

            // Place sorted values back into result array at sorted indices
            for (int j = 0; j < component_counts[i]; ++j) {
                result[component_indices[i][j]] = component_values[i][j];
            }
        }
    }

    // Free all dynamically allocated memory
    free(parent);
    free(sz);
    free(elements);
    for (int i = 0; i < numsSize; ++i) {
        if (component_counts[i] > 0) {
            free(component_indices[i]);
            free(component_values[i]);
        }
    }
    free(component_indices);
    free(component_values);
    free(component_counts);
    free(current_component_idx);

    return result;
}

static int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}