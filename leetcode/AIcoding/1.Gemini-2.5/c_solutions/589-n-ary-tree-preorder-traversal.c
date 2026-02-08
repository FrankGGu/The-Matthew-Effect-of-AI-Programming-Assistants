#include <stdlib.h> // For malloc, realloc

struct Node {
    int val;
    int numChildren;
    struct Node** children;
};

static int* result_array;
static int current_size;
static int current_capacity;

void preorder_traverse(struct Node* node) {
    if (node == NULL) {
        return;
    }

    // Add current node's value to the result array
    if (current_size == current_capacity) {
        if (current_capacity == 0) {
            current_capacity = 1; // Initial capacity
        } else {
            current_capacity *= 2; // Double the capacity
        }
        result_array = (int*)realloc(result_array, current_capacity * sizeof(int));
        // In a real application, you'd check if realloc returned NULL
    }
    result_array[current_size++] = node->val;

    // Recursively traverse children
    for (int i = 0; i < node->numChildren; i++) {
        preorder_traverse(node->children[i]);
    }
}

int* preorder(struct Node* root, int* returnSize) {
    // Initialize global variables for each call
    result_array = NULL;
    current_size = 0;
    current_capacity = 0;

    preorder_traverse(root);

    // Set the return size
    *returnSize = current_size;

    // If no nodes were added, result_array might still be NULL or have excess capacity.
    // Reallocate to the exact size to save memory, or return NULL if empty.
    if (current_size == 0) {
        free(result_array); // Free any potential initial allocation if root was NULL
        return NULL;
    } else {
        result_array = (int*)realloc(result_array, current_size * sizeof(int));
        return result_array;
    }
}