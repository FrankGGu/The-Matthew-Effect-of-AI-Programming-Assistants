#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define MAX_PATH_BUFFER_SIZE 1024
#define INITIAL_RESULT_CAPACITY 16

void dfs(struct TreeNode* node, char* current_path_buffer, int current_path_len, 
         char*** result, int* result_size, int* result_capacity) {
    if (node == NULL) {
        return;
    }

    int len_before_node = current_path_len;

    // Append "->" if it's not the first node in the path
    if (current_path_len > 0) {
        current_path_len += snprintf(current_path_buffer + current_path_len, 
                                     MAX_PATH_BUFFER_SIZE - current_path_len, "->");
    }

    // Append current node's value
    current_path_len += snprintf(current_path_buffer + current_path_len, 
                                 MAX_PATH_BUFFER_SIZE - current_path_len, "%d", node->val);

    // If it's a leaf node
    if (node->left == NULL && node->right == NULL) {
        // Allocate memory for the path string and copy it
        char* path_str = (char*)malloc(current_path_len + 1);
        if (path_str == NULL) {
            return; // Allocation failed
        }
        strcpy(path_str, current_path_buffer);

        // Add to result array, reallocate if needed
        if (*result_size == *result_capacity) {
            *result_capacity *= 2;
            *result = (char**)realloc(*result, (*result_capacity) * sizeof(char*));
            if (*result == NULL) {
                free(path_str); // Clean up already allocated path_str
                return; // Reallocation failed
            }
        }
        (*result)[(*result_size)++] = path_str;
        return; // Leaf node, no further recursion needed from here
    }

    // Recurse for left and right children
    dfs(node->left, current_path_buffer, current_path_len, result, result_size, result_capacity);
    dfs(node->right, current_path_buffer, current_path_len, result, result_size, result_capacity);

    // Backtrack: restore current_path_buffer to its state before processing this node
    // This is done by setting the null terminator at the length before this node was appended.
    current_path_buffer[len_before_node] = '\0';
}

char** binaryTreePaths(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    if (root == NULL) {
        return NULL;
    }

    char** result = (char**)malloc(INITIAL_RESULT_CAPACITY * sizeof(char*));
    if (result == NULL) {
        return NULL; // Allocation failed
    }
    int result_capacity = INITIAL_RESULT_CAPACITY;

    char* current_path_buffer = (char*)malloc(MAX_PATH_BUFFER_SIZE * sizeof(char));
    if (current_path_buffer == NULL) {
        free(result);
        return NULL; // Allocation failed
    }
    current_path_buffer[0] = '\0'; // Initialize buffer as empty string

    dfs(root, current_path_buffer, 0, &result, returnSize, &result_capacity);

    free(current_path_buffer); // Free the temporary buffer used for current path construction

    // It's good practice to shrink the allocated memory to the actual size,
    // though not strictly required by LeetCode for many problems.
    if (*returnSize < result_capacity) {
        result = (char**)realloc(result, (*returnSize) * sizeof(char*));
        // If realloc fails, the original 'result' is still valid, but we ignore
        // potential failure here as it's a shrinking realloc.
    }

    return result;
}