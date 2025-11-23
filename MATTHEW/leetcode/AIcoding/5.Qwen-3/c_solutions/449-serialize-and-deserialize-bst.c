#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

char* serialize(struct TreeNode* root) {
    if (!root) return NULL;
    char* result = (char*)malloc(10000 * sizeof(char));
    char* ptr = result;
    void dfs_serialize(TreeNode* node) {
        if (!node) {
            strcpy(ptr, "N,");
            ptr += 2;
            return;
        }
        char temp[10];
        sprintf(temp, "%d,", node->val);
        strcpy(ptr, temp);
        ptr += strlen(temp);
        dfs_serialize(node->left);
        dfs_serialize(node->right);
    }
    dfs_serialize(root);
    return result;
}

TreeNode* deserialize(char* data) {
    if (!data || strcmp(data, "N,") == 0) return NULL;
    char* token = strtok(data, ",");
    TreeNode* root = (TreeNode*)malloc(sizeof(TreeNode));
    root->val = atoi(token);
    root->left = NULL;
    root->right = NULL;
    void dfs_deserialize(TreeNode* node) {
        token = strtok(NULL, ",");
        if (strcmp(token, "N") == 0) {
            node->left = NULL;
        } else {
            node->left = (TreeNode*)malloc(sizeof(TreeNode));
            node->left->val = atoi(token);
            node->left->left = NULL;
            node->left->right = NULL;
            dfs_deserialize(node->left);
        }
        token = strtok(NULL, ",");
        if (strcmp(token, "N") == 0) {
            node->right = NULL;
        } else {
            node->right = (TreeNode*)malloc(sizeof(TreeNode));
            node->right->val = atoi(token);
            node->right->left = NULL;
            node->right->right = NULL;
            dfs_deserialize(node->right);
        }
    }
    dfs_deserialize(root);
    return root;
}