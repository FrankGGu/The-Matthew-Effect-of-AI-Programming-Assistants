typedef struct {
    int* arr;
    int size;
} BST;

void inorder(struct TreeNode* root, BST* bst) {
    if (!root) return;
    inorder(root->left, bst);
    bst->arr[bst->size++] = root->val;
    inorder(root->right, bst);
}

BST* createBST(struct TreeNode* root) {
    BST* bst = (BST*)malloc(sizeof(BST));
    bst->arr = (int*)malloc(10000 * sizeof(int));
    bst->size = 0;
    inorder(root, bst);
    return bst;
}

int* closestNodes(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    BST* bst = createBST(root);
    int* result = (int*)malloc(queriesSize * 2 * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        int left = -1, right = -1;

        for (int j = 0; j < bst->size; j++) {
            if (bst->arr[j] < query) {
                left = bst->arr[j];
            }
            if (bst->arr[j] > query && right == -1) {
                right = bst->arr[j];
            }
        }

        result[i * 2] = left;
        result[i * 2 + 1] = right;
    }

    free(bst->arr);
    free(bst);
    return result;
}