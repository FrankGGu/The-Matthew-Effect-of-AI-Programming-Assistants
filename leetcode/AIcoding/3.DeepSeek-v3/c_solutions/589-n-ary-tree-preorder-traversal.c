typedef struct Node {
    int val;
    int numChildren;
    struct Node** children;
} Node;

void preorderHelper(Node* root, int* result, int* index) {
    if (root == NULL) return;

    result[(*index)++] = root->val;

    for (int i = 0; i < root->numChildren; i++) {
        preorderHelper(root->children[i], result, index);
    }
}

int* preorder(Node* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(10000 * sizeof(int));
    *returnSize = 0;

    preorderHelper(root, result, returnSize);

    return result;
}