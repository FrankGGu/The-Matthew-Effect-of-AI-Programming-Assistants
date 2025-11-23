#include <stdlib.h>
#include <string.h>
#include <stdio.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define INITIAL_BUFFER_SIZE 1024
#define MAX_NUM_STR_LEN 12 

void append_str(char** buffer, int* current_len, int* max_len, const char* str_to_add) {
    int len_to_add = strlen(str_to_add);
    while (*current_len + len_to_add + 1 > *max_len) {
        *max_len *= 2;
        *buffer = (char*)realloc(*buffer, *max_len);
        if (*buffer == NULL) {
            exit(EXIT_FAILURE);
        }
    }
    strcpy(*buffer + *current_len, str_to_add);
    *current_len += len_to_add;
}

void serialize_dfs(struct TreeNode* root, char** buffer, int* current_len, int* max_len) {
    if (root == NULL) {
        append_str(buffer, current_len, max_len, "N,");
        return;
    }

    char num_str[MAX_NUM_STR_LEN];
    sprintf(num_str, "%d,", root->val);
    append_str(buffer, current_len, max_len, num_str);

    serialize_dfs(root->left, buffer, current_len, max_len);
    serialize_dfs(root->right, buffer, current_len, max_len);
}

char* serialize(struct TreeNode* root) {
    char* buffer = (char*)malloc(INITIAL_BUFFER_SIZE);
    if (buffer == NULL) {
        exit(EXIT_FAILURE);
    }
    int current_len = 0;
    int max_len = INITIAL_BUFFER_SIZE;

    serialize_dfs(root, &buffer, &current_len, &max_len);

    if (current_len > 0 && buffer[current_len - 1] == ',') {
        current_len--;
    }
    buffer[current_len] = '\0';

    buffer = (char*)realloc(buffer, current_len + 1);
    if (buffer == NULL) {
        exit(EXIT_FAILURE);
    }
    return buffer;
}

struct TreeNode* deserialize_dfs(char*** tokens_ptr, int* index_ptr, int num_tokens) {
    if (*index_ptr >= num_tokens) {
        return NULL;
    }

    char* token = (*tokens_ptr)[*index_ptr];
    (*index_ptr)++;

    if (strcmp(token, "N") == 0) {
        return NULL;
    }

    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    if (node == NULL) {
        exit(EXIT_FAILURE);
    }
    node->val = atoi(token);
    node->left = deserialize_dfs(tokens_ptr, index_ptr, num_tokens);
    node->right = deserialize_dfs(tokens_ptr, index_ptr, num_tokens);

    return node;
}

struct TreeNode* deserialize(char* data) {
    if (data == NULL || strlen(data) == 0) {
        return NULL;
    }

    char* data_copy_for_strtok = strdup(data);
    if (data_copy_for_strtok == NULL) {
        exit(EXIT_FAILURE);
    }

    int num_tokens = 0;
    char* temp_copy_for_count = strdup(data);
    if (temp_copy_for_count == NULL) {
        free(data_copy_for_strtok);
        exit(EXIT_FAILURE);
    }
    char* token_count = strtok(temp_copy_for_count, ",");
    while (token_count != NULL) {
        num_tokens++;
        token_count = strtok(NULL, ",");
    }
    free(temp_copy_for_count);

    char** tokens = (char**)malloc(sizeof(char*) * num_tokens);
    if (tokens == NULL) {
        free(data_copy_for_strtok);
        exit(EXIT_FAILURE);
    }

    int i = 0;
    char* current_token = strtok(data_copy_for_strtok, ",");
    while (current_token != NULL) {
        tokens[i++] = current_token;
        current_token = strtok(NULL, ",");
    }

    int index = 0;
    struct TreeNode* root = deserialize_dfs(&tokens, &index, num_tokens);

    free(tokens);
    free(data_copy_for_strtok);

    return root;
}