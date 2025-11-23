#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isSubStructureHelper(struct TreeNode* A, struct TreeNode* B) {
    if (B == NULL) return true;
    if (A == NULL) return false;
    if (A->val != B->val) return false;
    return isSubStructureHelper(A->left, B->left) && isSubStructureHelper(A->right, B->right);
}

bool isSubStructure(struct TreeNode* A, struct TreeNode* B) {
    if (A == NULL || B == NULL) return false;
    if (isSubStructureHelper(A, B)) return true;
    return isSubStructure(A->left, B) || isSubStructure(A->right, B);
}