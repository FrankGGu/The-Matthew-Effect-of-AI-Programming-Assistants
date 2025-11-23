void inorder(struct TreeNode* root, int* arr, int* index) {
    if (root == NULL) return;
    inorder(root->left, arr, index);
    arr[(*index)++] = root->val;
    inorder(root->right, arr, index);
}

int countNodes(struct TreeNode* root) {
    if (root == NULL) return 0;
    return 1 + countNodes(root->left) + countNodes(root->right);
}

int* getAllElements(struct TreeNode* root1, struct TreeNode* root2, int* returnSize) {
    int size1 = countNodes(root1);
    int size2 = countNodes(root2);
    *returnSize = size1 + size2;

    int* arr1 = (int*)malloc(size1 * sizeof(int));
    int* arr2 = (int*)malloc(size2 * sizeof(int));
    int* result = (int*)malloc((*returnSize) * sizeof(int));

    int idx1 = 0, idx2 = 0;
    inorder(root1, arr1, &idx1);
    inorder(root2, arr2, &idx2);

    int i = 0, j = 0, k = 0;
    while (i < size1 && j < size2) {
        if (arr1[i] <= arr2[j]) {
            result[k++] = arr1[i++];
        } else {
            result[k++] = arr2[j++];
        }
    }

    while (i < size1) result[k++] = arr1[i++];
    while (j < size2) result[k++] = arr2[j++];

    free(arr1);
    free(arr2);

    return result;
}