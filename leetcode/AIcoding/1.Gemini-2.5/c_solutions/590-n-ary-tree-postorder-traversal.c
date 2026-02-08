void postorderTraversalRecursive(struct Node* root, int** result, int* returnSize, int* capacity) {
    if (!root) {
        return;
    }

    for (int i = 0; i < root->numChildren; i++) {
        postorderTraversalRecursive(root->children[i], result, returnSize, capacity);
    }

    if (*returnSize == *capacity) {
        *capacity *= 2;
        *result = (int*)realloc(*result, sizeof(int) * (*capacity));
    }
    (*result)[(*returnSize)++] = root->val;
}

int* postorder(struct Node* root, int* returnSize) {
    *returnSize = 0;
    int capacity = 50; 
    int* result = (int*)malloc(sizeof(int) * capacity);

    postorderTraversalRecursive(root, &result, returnSize, &capacity);

    return result;
}