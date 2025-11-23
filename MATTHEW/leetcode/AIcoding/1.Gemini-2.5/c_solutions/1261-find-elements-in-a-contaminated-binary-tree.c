#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define MAX_VAL_PLUS_ONE (1 << 21)

typedef struct {
    bool *recovered_values;
} FindElements;

void recover_tree_values(struct TreeNode* node, int current_val, FindElements* obj) {
    if (node == NULL) {
        return;
    }

    obj->recovered_values[current_val] = true;

    if (node->left != NULL) {
        recover_tree_values(node->left, 2 * current_val + 1, obj);
    }

    if (node->right != NULL) {
        recover_tree_values(node->right, 2 * current_val + 2, obj);
    }
}

FindElements* findElementsCreate(struct TreeNode* root) {
    FindElements* obj = (FindElements*)malloc(sizeof(FindElements));
    if (obj == NULL) {
        return NULL;
    }

    obj->recovered_values = (bool*)calloc(MAX_VAL_PLUS_ONE, sizeof(bool));
    if (obj->recovered_values == NULL) {
        free(obj);
        return NULL;
    }

    if (root != NULL) {
        recover_tree_values(root, 0, obj);
    }

    return obj;
}

bool findElementsFind(FindElements* obj, int val) {
    if (obj == NULL || obj->recovered_values == NULL) {
        return false;
    }

    if (val >= 0 && val < MAX_VAL_PLUS_ONE) {
        return obj->recovered_values[val];
    }

    return false;
}

void findElementsFree(FindElements* obj) {
    if (obj != NULL) {
        free(obj->recovered_values);
        free(obj);
    }
}