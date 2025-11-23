#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void serialize_helper(struct TreeNode* root, char** buffer, int* current_len, int* max_len) {
    if (root == NULL) {
        return;
    }

    // Determine the length needed for the current number and a space
    int needed = snprintf(NULL, 0, "%d ", root->val); 

    // Resize buffer if necessary
    if (*current_len + needed + 1 > *max_len) { // +1 for null terminator
        *max_len = (*current_len + needed + 1) * 2; // Double the capacity
        *buffer = (char*)realloc(*buffer, *max_len);
        if (*buffer == NULL) {
            // Handle realloc failure (e.g., by exiting or setting an error flag)
            return; 
        }
    }

    // Append the current node's value to the buffer
    *current_len += sprintf(*buffer + *current_len, "%d ", root->val);

    serialize_helper(root->left, buffer, current_len, max_len);
    serialize_helper(root->right, buffer, current_len, max_len);
}

char* serialize(struct TreeNode* root) {
    if (root == NULL) {
        char* empty_str = (char*)malloc(1);
        if (empty_str) empty_str[0] = '\0';
        return empty_str;
    }

    // Initial buffer size guess (e.g., for 10^4 nodes, each up to 5 digits + space)
    int initial_max_len = 1024; 
    char* buffer = (char*)malloc(initial_max_len);
    if (buffer == NULL) {
        return NULL; 
    }
    int current_len = 0;
    int max_len = initial_max_len;

    serialize_helper(root, &buffer, &current_len, &max_len);

    // Remove the trailing space if the string is not empty
    if (current_len > 0 && buffer[current_len - 1] == ' ') {
        buffer[current_len - 1] = '\0';
        current_len--;
    } else {
        buffer[current_len] = '\0'; // Ensure null termination for empty string or no trailing space
    }

    // Shrink the buffer to fit the actual content
    buffer = (char*)realloc(buffer, current_len + 1);
    return buffer;
}

struct TreeNode* deserialize_helper(int* nums, int* index_ptr, int count, int min_val, int max_val) {
    // If all numbers are processed or current number is out of bounds for this subtree
    if (*index_ptr >= count || nums[*index_ptr] < min_val || nums[*index_ptr] > max_val) {
        return NULL;
    }

    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    if (node == NULL) {
        return NULL; // Handle allocation failure
    }
    node->val = nums[*index_ptr];
    (*index_ptr)++; // Move to the next number for children

    // Recursively build the left subtree
    // Left child must be less than current node's value
    node->left = deserialize_helper(nums, index_ptr, count, min_val, node->val);

    // Recursively build the right subtree
    // Right child must be greater than current node's value
    node->right = deserialize_helper(nums, index_ptr, count, node->val, max_val);

    return node;
}

struct TreeNode* deserialize(char* data) {
    if (data == NULL || data[0] == '\0') {
        return NULL;
    }

    // First pass: count the numbers to allocate memory for the integer array
    int count = 0;
    char* temp_data_for_count = strdup(data);
    if (temp_data_for_count == NULL) return NULL;

    char* token = strtok(temp_data_for_count, " ");
    while (token != NULL) {
        count++;
        token = strtok(NULL, " ");
    }
    free(temp_data_for_count);

    if (count == 0) {
        return NULL;
    }

    int* nums = (int*)malloc(count * sizeof(int));
    if (nums == NULL) {
        return NULL; 
    }

    // Second pass: parse the string into the integer array
    char* data_copy_for_parse = strdup(data);
    if (data_copy_for_parse == NULL) {
        free(nums);
        return NULL;
    }
    char* ptr = data_copy_for_parse;
    int val_read;
    int offset;
    int i = 0;

    while (sscanf(ptr, "%d%n", &val_read, &offset) == 1 && i < count) {
        nums[i++] = val_read;
        ptr += offset;
        // Skip any leading spaces for the next read
        while (*ptr == ' ') {
            ptr++;
        }
    }
    free(data_copy_for_parse);

    // Reconstruct the BST using the parsed numbers
    int index = 0;
    struct TreeNode* root = deserialize_helper(nums, &index, count, INT_MIN, INT_MAX);

    free(nums); // Free the temporary array of numbers

    return root;
}