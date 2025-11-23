#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    TreeNode* root;
    int* seen;
    int size;
} FindElements;

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

FindElements* findElementsCreate(TreeNode* root) {
    FindElements* obj = (FindElements*)malloc(sizeof(FindElements));
    obj->root = root;
    obj->seen = NULL;
    obj->size = 0;
    return obj;
}

void dfs(FindElements* obj, TreeNode* node, int val) {
    if (!node) return;
    node->val = val;
    if (obj->size <= val) {
        int new_size = (val + 1) * 2;
        obj->seen = (int*)realloc(obj->seen, new_size * sizeof(int));
        for (int i = obj->size; i < new_size; i++) {
            obj->seen[i] = 0;
        }
        obj->size = new_size;
    }
    obj->seen[val] = 1;
    dfs(obj, node->left, 2 * val + 1);
    dfs(obj, node->right, 2 * val + 2);
}

bool findElementsContains(FindElements* obj, int key) {
    if (key >= obj->size) {
        return false;
    }
    return obj->seen[key] == 1;
}

void findElementsFree(FindElements* obj) {
    free(obj->seen);
    free(obj);
}