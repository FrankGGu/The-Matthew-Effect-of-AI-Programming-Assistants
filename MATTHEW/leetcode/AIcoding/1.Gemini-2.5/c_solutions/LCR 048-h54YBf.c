#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void serialize_helper(struct TreeNode* root, char** buffer, int* current_len, int* max_len) {
    // Reallocate buffer if not enough space (estimate space for "null," or "12345," which is around 10 chars)
    if (*current_len + 16 >= *max_len) { 
        *max_len *= 2;
        *buffer = (char*)realloc(*buffer, *max_len);
        if (*buffer == NULL) {
            // Handle realloc failure, though LeetCode environments usually guarantee success for reasonable sizes
            return;
        }
    }

    if (root == NULL) {
        strcpy(*buffer + *current_len, "null,");
        *current_len += 5; // "null," has 5 characters
        return;
    }

    // Convert integer value to string and append to buffer
    int val_len = sprintf(*buffer + *current_len, "%d,", root->val);
    *current_len += val_len;

    serialize_helper(root->left, buffer, current_len, max_len);
    serialize_helper(root->right, buffer, current_len, max_len);
}

char* serialize(struct TreeNode* root) {
    int initial_max_len = 1024; // Start with a reasonable buffer size
    char* buffer = (char*)malloc(initial_max_len);
    if (buffer == NULL) {
        return NULL; // Handle malloc failure
    }
    int current_len = 0;
    int max_len = initial_max_len;

    serialize_helper(root, &buffer, &current_len, &max_len);

    // Remove the trailing comma if the string is not empty, and null-terminate.
    if (current_len > 0 && buffer[current_len - 1] == ',') {
        buffer[current_len - 1] = '\0';
    } else {
        buffer[current_len] = '\0'; // Just null-terminate (e.g., for an empty tree resulting in "null")
    }

    return buffer;
}

struct TreeNode* deserialize_helper(char** data_ptr) {
    if (*data_ptr == NULL || **data_ptr == '\0') {
        return NULL;
    }

    char* comma_pos = strchr(*data_ptr, ',');
    char token[16]; // Sufficient buffer for "null" or integer values like "-1000"

    int token_len;
    if (comma_pos == NULL) { // This is the last token in the string
        token_len = strlen(*data_ptr);
        strncpy(token, *data_ptr, token_len);
        token[token_len] = '\0';
        *data_ptr = NULL; // Mark that all data has been consumed
    } else {
        token_len = comma_pos - *data_ptr;
        strncpy(token, *data_ptr, token_len);
        token[token_len] = '\0';
        *data_ptr = comma_pos + 1; // Move pointer past the current token and comma
    }

    if (strcmp(token, "null") == 0) {
        return NULL;
    }

    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    if (node == NULL) {
        return NULL; // Handle malloc failure
    }
    node->val = atoi(token); // Convert string token to integer

    node->left = deserialize_helper(data_ptr);
    node->right = deserialize_helper(data_ptr);

    return node;
}

struct TreeNode* deserialize(char* data) {
    if (data == NULL || *data == '\0') {
        return NULL;
    }
    // Pass a pointer to the data string, so recursive calls can modify its position
    return deserialize_helper(&data);
}