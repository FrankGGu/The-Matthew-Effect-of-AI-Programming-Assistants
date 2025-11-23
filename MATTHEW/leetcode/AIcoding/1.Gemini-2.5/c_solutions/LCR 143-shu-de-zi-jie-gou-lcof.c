bool isSameTree(struct TreeNode* p, struct TreeNode* q) {
    if (q == NULL) {
        return true; // If B is exhausted, it means all its nodes matched
    }
    if (p == NULL || p->val != q->val) {
        return false; // If A is exhausted before B, or values don't match
    }
    return isSameTree(p->left, q->left) && isSameTree(p->right, q->right);
}

bool isSubStructure(struct TreeNode* A, struct TreeNode* B) {
    if (A == NULL || B == NULL) {
        return false; // If A or B is empty, B cannot be a substructure (assuming B is non-empty as per problem context)
    }

    // Check if B is identical to A starting from the current node A
    // OR if B is a substructure of A's left child
    // OR if B is a substructure of A's right child
    return isSameTree(A, B) || isSubStructure(A->left, B) || isSubStructure(A->right, B);
}