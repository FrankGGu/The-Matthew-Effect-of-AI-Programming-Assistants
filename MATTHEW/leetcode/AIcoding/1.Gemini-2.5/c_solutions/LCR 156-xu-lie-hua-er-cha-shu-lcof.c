#include <stdlib.h> // For malloc, free, realloc, atoi
#include <stdio.h>  // For sprintf
#include <string.h> // For strlen, strcpy, strcmp, strchr

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void append_to_buffer(char** buffer_ptr, int* current_len_ptr, int* max_len_ptr, const char* str_to_append) {
    int len_to_add = strlen(str_to_append);

    // Check if there's enough space for the new string + null terminator
    if (*current_len_ptr + len_to_add + 1 > *max_len_ptr) {
        // If max_len is 0 (initial state), set an initial size, otherwise double it.
        *max_len_ptr = (*max_len_ptr == 0) ? 1024 : (*max_len_ptr * 2);
        char* new_buffer = (char*)realloc(*buffer_ptr, *max_len_ptr);
        // In a real application, realloc failure should be handled.
        // For LeetCode, we typically assume realloc succeeds.
        if (new_buffer == NULL) {
            // If realloc fails, we might be in an inconsistent state.
            // For this problem, we'll proceed assuming it works.
            return;
        }
        *buffer_ptr = new_buffer;
    }

    // Append the string and update current_len
    strcpy(*buffer_ptr + *current_len_ptr, str_to_append);
    *current_len_ptr += len_to_add;
}

void serialize_recursive(struct TreeNode* root, char** buffer_ptr, int* current_len_ptr, int* max_len_ptr) {
    char temp[32]; // Sufficient for integer string (e.g., -2147483648 is 11 chars) + comma + null

    if (root == NULL) {
        strcpy(temp, "N,"); // 'N' for null node, followed by a comma delimiter
        append_to_buffer(buffer_ptr, current_len_ptr, max_len_ptr, temp);
        return;
    }

    // Convert integer value to string, followed by a comma delimiter
    sprintf(temp, "%d,", root->val);
    append_to_buffer(buffer_ptr, current_len_ptr, max_len_ptr, temp);

    // Recursively serialize left and right children
    serialize_recursive(root->left, buffer_ptr, current_len_ptr, max_len_ptr);
    serialize_recursive(root->right, buffer_ptr, current_len_ptr, max_len_ptr);
}

char* serialize(struct TreeNode* root) {
    char* buffer = NULL;
    int current_len = 0; // Current length of the string in buffer (excluding null terminator)
    int max_len = 0;     // Current allocated size of the buffer

    // Start the recursive serialization process
    serialize_recursive(root, &buffer, &current_len, &max_len);

    // Ensure the final string is null-terminated.
    // append_to_buffer ensures `current_len` is the length of the string.
    // We need to ensure `buffer[current_len]` is '\0'.
    // `current_len + 1` is the total size needed for the string + null terminator.
    if (buffer == NULL) {
        // This case should ideally not be reached if serialize_recursive is called,
        // as even for a NULL root, "N," is appended.
        // However, as a safeguard, if for some reason buffer is still NULL,
        // return an empty string or a specific error indicator.
        // For LeetCode, an empty tree serializes to "N,"
        buffer = (char*)malloc(3); // "N," + '\0'
        if (buffer) strcpy(buffer, "N,");
        return buffer;
    }

    // If the buffer was exactly filled by the last append, we need one more byte for '\0'.
    if (current_len + 1 > max_len) {
        char* new_buffer = (char*)realloc(buffer, current_len + 1);
        if (new_buffer) buffer = new_buffer;
    }
    // Place the null terminator
    if (buffer) { // Ensure buffer is not NULL after potential realloc failure
        buffer[current_len] = '\0';
    }

    return buffer;
}

struct TreeNode* deserialize_recursive(char** data_ptr) {
    // Find the next token (until the next comma)
    char* token_start = *data_ptr;
    char* comma_pos = strchr(token_start, ',');

    // If no comma is found, the string is malformed or ended unexpectedly.
    // For LeetCode, assume well-formed input.
    if (comma_pos == NULL) {
        return NULL;
    }

    // Temporarily null-terminate the token to treat it as a separate string.
    *comma_pos = '\0';
    char* token = token_start;

    // Advance data_ptr past the comma for the next recursive call.
    *data_ptr = comma_pos + 1;

    // If the token is "N", it signifies a null node.
    if (strcmp(token, "N") == 0) {
        return NULL;
    }

    // Otherwise, create a new TreeNode and parse its value.
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    if (node == NULL) {
        // Handle allocation failure
        return NULL;
    }

    node->val = atoi(token); // Convert string token to integer

    // Recursively build the left and right subtrees
    node->left = deserialize_recursive(data_ptr);
    node->right = deserialize_recursive(data_ptr);

    return node;
}

struct TreeNode* deserialize(char* data) {
    // Handle empty or null input string.
    if (data == NULL || *data == '\0') {
        return NULL;
    }
    // The `deserialize_recursive` function modifies the input `data` string
    // by inserting null terminators. We pass a pointer to `data` so it can be updated
    // across recursive calls.
    return deserialize_recursive(&data);
}