#include <stdlib.h> // For malloc, realloc, free
#include <stdbool.h> // For bool

static int voyage_idx;
static int* result_list;
static int result_capacity;
static int result_size;
static bool possible;

static void add_to_result(int val) {
    if (result_size == result_capacity) {
        result_capacity *= 2;
        result_list = (int*)realloc(result_list, result_capacity * sizeof(int));
    }
    result_list[result_size++] = val;
}

static void dfs(struct TreeNode* node, int* voyage, int voyageSize) {
    // If current node is NULL or we've already found an impossible scenario, stop.
    if (node == NULL || !possible) {
        return;
    }

    // Check if the current node's value matches the expected value in voyage
    if (node->val != voyage[voyage_idx]) {
        possible = false;
        return;
    }
    voyage_idx++; // Move to the next expected value in voyage

    // Determine traversal order for children
    // Case 1: Normal traversal (left child first, then right child)
    // This happens if there is no left child, or if the left child's value matches the next expected value in voyage.
    // The `voyage_idx < voyageSize` check prevents out-of-bounds access if we've consumed all voyage elements.
    if (node->left == NULL || (voyage_idx < voyageSize && node->left->val == voyage[voyage_idx])) {
        dfs(node->left, voyage, voyageSize);
        dfs(node->right, voyage, voyageSize);
    }
    // Case 2: Flip required
    // This happens if there is a left child, but its value does NOT match the next expected value in voyage,
    // AND there is a right child, and its value DOES match the next expected value in voyage.
    else if (node->right != NULL && (voyage_idx < voyageSize && node->right->val == voyage[voyage_idx])) {
        add_to_result(node->val); // Record the flip
        dfs(node->right, voyage, voyageSize); // Traverse right child first
        dfs(node->left, voyage, voyageSize);  // Then traverse left child
    }
    // Case 3: Impossible traversal
    // This covers all other scenarios where a match cannot be made:
    // - Left child exists, but its value doesn't match, AND right child is NULL or its value doesn't match.
    // In this case, it's impossible to match the preorder traversal.
    else {
        possible = false;
        return;
    }
}

int* flipMatchVoyage(struct TreeNode* root, int* voyage, int voyageSize, int* returnSize) {
    // Initialize global state
    voyage_idx = 0;
    result_capacity = voyageSize; // Max flips is voyageSize - 1, so voyageSize is a safe initial capacity.
    result_list = (int*)malloc(result_capacity * sizeof(int));
    result_size = 0;
    possible = true;

    // Start DFS from the root
    dfs(root, voyage, voyageSize);

    // After DFS, check if a valid traversal was possible
    if (!possible) {
        // If not possible, return [-1]
        free(result_list); // Free the allocated memory for result_list
        *returnSize = 1;
        int* impossible_result = (int*)malloc(sizeof(int));
        impossible_result[0] = -1;
        return impossible_result;
    } else {
        // If possible, return the list of flipped nodes
        *returnSize = result_size;
        // Reallocate to exact size to avoid memory leak if result_capacity was larger
        // If result_size is 0, realloc with 0 size might return NULL or a valid pointer.
        // It's safer to handle 0 size explicitly or ensure realloc handles it.
        // For LeetCode, `realloc(ptr, 0)` often frees `ptr` and returns `NULL`.
        // If `result_size` is 0, we want to return a valid empty array.
        if (result_size == 0) {
            free(result_list); // Free the initial allocation
            return (int*)malloc(0); // Return a valid empty array pointer
        }
        result_list = (int*)realloc(result_list, result_size * sizeof(int));
        return result_list;
    }
}