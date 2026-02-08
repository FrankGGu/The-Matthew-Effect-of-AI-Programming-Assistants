#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "uthash.h"

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct MapEntry {
    char* key;
    int count;
    struct TreeNode* node_ptr;
    UT_hash_handle hh;
} MapEntry;

MapEntry *g_map = NULL;
struct TreeNode** g_result = NULL;
int g_returnSize = 0;
int g_result_capacity = 0;

char* serialize_subtree(struct TreeNode* root) {
    if (!root) {
        return strdup("#");
    }

    char* left_s = serialize_subtree(root->left);
    char* right_s = serialize_subtree(root->right);

    char val_str[15];
    sprintf(val_str, "%d", root->val);

    int len = strlen(val_str) + 1 + strlen(left_s) + 1 + strlen(right_s) + 1;
    char* current_s = (char*)malloc(len);
    sprintf(current_s, "%s,%s,%s", val_str, left_s, right_s);

    free(left_s);
    free(right_s);

    MapEntry *entry;
    HASH_FIND_STR(g_map, current_s, entry);

    if (entry == NULL) {
        entry = (MapEntry*)malloc(sizeof(MapEntry));
        entry->key = current_s;
        entry->count = 1;
        entry->node_ptr = root;
        HASH_ADD_STR(g_map, key, entry);
    } else {
        entry->count++;
        free(current_s);
        if (entry->count == 2) {
            if (g_returnSize == g_result_capacity) {
                g_result_capacity = (g_result_capacity == 0) ? 1 : g_result_capacity * 2;
                g_result = (struct TreeNode**)realloc(g_result, g_result_capacity * sizeof(struct TreeNode*));
            }
            g_result[g_returnSize++] = entry->node_ptr;
        }
    }
    return entry->key;
}

struct TreeNode** findDuplicateSubtrees(struct TreeNode* root, int* returnSize) {
    g_map = NULL;
    if (g_result) {
        free(g_result);
        g_result = NULL;
    }
    g_returnSize = 0;
    g_result_capacity = 0;

    char* final_s = serialize_subtree(root);
    if (root == NULL && final_s != NULL) {
        free(final_s);
    }

    MapEntry *current_entry, *tmp_entry;
    HASH_ITER(hh, g_map, current_entry, tmp_entry) {
        HASH_DEL(g_map, current_entry);
        free(current_entry->key);
        free(current_entry);
    }

    *returnSize = g_returnSize;
    return g_result;
}