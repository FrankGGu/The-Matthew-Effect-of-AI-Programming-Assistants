void postorderHelper(struct Node* root, int* result, int* index) {
    if (root == NULL) return;

    for (int i = 0; i < root->numChildren; i++) {
        postorderHelper(root->children[i], result, index);
    }

    result[(*index)++] = root->val;
}

int* postorder(struct Node* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(10000 * sizeof(int));
    *returnSize = 0;

    postorderHelper(root, result, returnSize);

    return result;
}