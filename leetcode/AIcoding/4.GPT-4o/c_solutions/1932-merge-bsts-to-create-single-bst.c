void inorder(struct TreeNode* root, int* arr, int* index) {
    if (!root) return;
    inorder(root->left, arr, index);
    arr[(*index)++] = root->val;
    inorder(root->right, arr, index);
}

struct TreeNode* sortedArrayToBST(int* arr, int start, int end) {
    if (start > end) return NULL;
    int mid = start + (end - start) / 2;
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = arr[mid];
    node->left = sortedArrayToBST(arr, start, mid - 1);
    node->right = sortedArrayToBST(arr, mid + 1, end);
    return node;
}

struct TreeNode* mergeTrees(struct TreeNode** trees, int treesSize) {
    int* arr = (int*)malloc(10000 * sizeof(int));
    int index = 0;
    for (int i = 0; i < treesSize; i++) {
        inorder(trees[i], arr, &index);
    }
    qsort(arr, index, sizeof(int), cmp);
    return sortedArrayToBST(arr, 0, index - 1);
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}