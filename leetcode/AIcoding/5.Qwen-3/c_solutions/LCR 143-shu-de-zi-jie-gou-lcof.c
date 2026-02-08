#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int isSubStructure(struct TreeNode* A, struct TreeNode* B) {
    if (B == NULL) return 0;
    if (A == NULL) return 0;

    int result = 0;
    if (A->val == B->val) {
        result = isSubStructureHelper(A, B);
    }
    if (!result) {
        result = isSubStructure(A->left, B);
    }
    if (!result) {
        result = isSubStructure(A->right, B);
    }
    return result;
}

int isSubStructureHelper(struct TreeNode* A, struct TreeNode* B) {
    if (B == NULL) return 1;
    if (A == NULL) return 0;
    if (A->val != B->val) return 0;
    return isSubStructureHelper(A->left, B->left) && isSubStructureHelper(A->right, B->right);
}