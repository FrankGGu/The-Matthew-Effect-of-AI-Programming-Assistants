#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode* root;
} FindElements;

FindElements* findElementsCreate(struct TreeNode* root) {
    FindElements* obj = (FindElements*)malloc(sizeof(FindElements));
    obj->root = root;
    if (root != NULL) {
        root->val = 0;
        recoverTree(root);
    }
    return obj;
}

void recoverTree(struct TreeNode* root) {
    if (root == NULL) return;
    if (root->left != NULL) {
        root->left->val = 2 * root->val + 1;
        recoverTree(root->left);
    }
    if (root->right != NULL) {
        root->right->val = 2 * root->val + 2;
        recoverTree(root->right);
    }
}

bool findElementsFind(FindElements* obj, int target) {
    if (obj->root == NULL) return false;
    struct TreeNode* curr = obj->root;
    int path[32];
    int len = 0;

    if(target == 0) return true;

    while(target > 0){
        path[len++] = target % 2;
        target = (target - path[len - 1]) / 2;
    }

    for(int i = len - 2; i >= 0; i--){
        if(path[i] == 1){
            curr = curr->left;
        } else {
            curr = curr->right;
        }
        if(curr == NULL) return false;
    }
    return true;
}

void findElementsFree(FindElements* obj) {
    free(obj);
}