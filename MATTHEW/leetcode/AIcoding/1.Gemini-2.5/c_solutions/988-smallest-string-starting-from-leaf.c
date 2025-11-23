#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

char* global_min_string = NULL;

void dfs(struct TreeNode* node, char* current_path_buffer, int current_path_len) {
    if (node == NULL) {
        return;
    }

    current_path_buffer[current_path_len] = (char)('a' + node->val);
    current_path_len++;

    if (node->left == NULL && node->right == NULL) {
        char* leaf_to_root_string = (char*)malloc(current_path_len + 1);
        for (int i = 0; i < current_path_len; i++) {
            leaf_to_root_string[i] = current_path_buffer[current_path_len - 1 - i];
        }
        leaf_to_root_string[current_path_len] = '\0';

        if (global_min_string == NULL || strcmp(leaf_to_root_string, global_min_string) < 0) {
            if (global_min_string != NULL) {
                free(global_min_string);
            }
            global_min_string = leaf_to_root_string;
        } else {
            free(leaf_to_root_string);
        }
    } else {
        dfs(node->left, current_path_buffer, current_path_len);
        dfs(node->right, current_path_buffer, current_path_len);
    }
}

char* smallestFromLeaf(struct TreeNode* root) {
    if (global_min_string != NULL) {
        free(global_min_string);
        global_min_string = NULL;
    }

    char path_buffer[851];

    dfs(root, path_buffer, 0);

    return global_min_string;
}