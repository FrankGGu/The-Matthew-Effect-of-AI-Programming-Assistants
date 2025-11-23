#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode* root;
    bool* found;
    int size;
} FindElements;

void recover(struct TreeNode* node, int val, bool* found, int* maxVal) {
    if (!node) return;
    node->val = val;
    if (val >= *maxVal) *maxVal = val;
    if (val < 1000000) found[val] = true;
    recover(node->left, 2 * val + 1, found, maxVal);
    recover(node->right, 2 * val + 2, found, maxVal);
}

FindElements* findElementsCreate(struct TreeNode* root) {
    FindElements* obj = (FindElements*)malloc(sizeof(FindElements));
    obj->root = root;
    obj->size = 1000000;
    obj->found = (bool*)calloc(obj->size, sizeof(bool));
    int maxVal = 0;
    recover(root, 0, obj->found, &maxVal);
    return obj;
}

bool findElementsFind(FindElements* obj, int target) {
    if (target < 0 || target >= obj->size) return false;
    return obj->found[target];
}

void findElementsFree(FindElements* obj) {
    free(obj->found);
    free(obj);
}