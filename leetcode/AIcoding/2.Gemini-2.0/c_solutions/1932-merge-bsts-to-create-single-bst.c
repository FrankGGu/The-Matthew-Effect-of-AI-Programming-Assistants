#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* mergeBSTs(struct TreeNode** trees, int treesSize) {
    if (treesSize == 0) return NULL;
    if (treesSize == 1) return trees[0];

    int n = treesSize;
    int inDegree[n];
    for (int i = 0; i < n; i++) inDegree[i] = 0;

    int rootVal[n];
    for (int i = 0; i < n; i++) rootVal[i] = trees[i]->val;

    bool isRoot[n];
    for (int i = 0; i < n; i++) isRoot[i] = true;

    struct TreeNode* valToNode[100001];
    for (int i = 0; i < 100001; i++) valToNode[i] = NULL;

    for (int i = 0; i < n; i++) {
        valToNode[trees[i]->val] = trees[i];
    }

    for (int i = 0; i < n; i++) {
        if (trees[i]->left) {
            int leftVal = trees[i]->left->val;
            for (int j = 0; j < n; j++) {
                if (rootVal[j] == leftVal) {
                    inDegree[i]++;
                    isRoot[j] = false;
                }
            }
        }
        if (trees[i]->right) {
            int rightVal = trees[i]->right->val;
            for (int j = 0; j < n; j++) {
                if (rootVal[j] == rightVal) {
                    inDegree[i]++;
                    isRoot[j] = false;
                }
            }
        }
    }

    int rootIndex = -1;
    for (int i = 0; i < n; i++) {
        if (isRoot[i]) {
            if (rootIndex != -1) return NULL; 
            rootIndex = i;
        }
    }

    if (rootIndex == -1) return NULL;

    struct TreeNode* root = trees[rootIndex];

    bool changed = true;
    while (changed) {
        changed = false;
        for (int i = 0; i < n; i++) {
            if (i == rootIndex) continue;

            if (valToNode[trees[i]->val] == NULL) continue;

            if (trees[i]->val < root->val) {
                if (root->left == NULL) {
                    root->left = trees[i];
                    valToNode[trees[i]->val] = NULL;
                    changed = true;
                } else {
                    struct TreeNode* curr = root->left;
                    while (curr->right != NULL) {
                        curr = curr->right;
                    }
                    if (trees[i]->val > curr->val) {
                        curr->right = trees[i];
                        valToNode[trees[i]->val] = NULL;
                        changed = true;
                    }
                }
            } else {
                if (root->right == NULL) {
                    root->right = trees[i];
                    valToNode[trees[i]->val] = NULL;
                    changed = true;
                } else {
                    struct TreeNode* curr = root->right;
                    while (curr->left != NULL) {
                        curr = curr->left;
                    }
                    if (trees[i]->val < curr->val) {
                        curr->left = trees[i];
                        valToNode[trees[i]->val] = NULL;
                        changed = true;
                    }
                }
            }
        }
    }

    bool valid = true;
    int prev = -1;

    struct TreeNode* stack[10000];
    int top = -1;
    struct TreeNode* curr = root;

    while (curr != NULL || top != -1) {
        while (curr != NULL) {
            stack[++top] = curr;
            curr = curr->left;
        }

        curr = stack[top--];
        if (prev != -1 && curr->val <= prev) {
            valid = false;
            break;
        }
        prev = curr->val;
        curr = curr->right;
    }

    if (!valid) return NULL;

    return root;
}