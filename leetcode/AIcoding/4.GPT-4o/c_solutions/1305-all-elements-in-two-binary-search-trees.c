void inorder(struct TreeNode* root, int* arr, int* index) {
    if (root == NULL) return;
    inorder(root->left, arr, index);
    arr[(*index)++] = root->val;
    inorder(root->right, arr, index);
}

int* getAllElements(struct TreeNode* root1, struct TreeNode* root2, int* returnSize) {
    int size1 = 0, size2 = 0;
    int* arr1 = (int*)malloc(10000 * sizeof(int));
    int* arr2 = (int*)malloc(10000 * sizeof(int));

    inorder(root1, arr1, &size1);
    inorder(root2, arr2, &size2);

    int* result = (int*)malloc((size1 + size2) * sizeof(int));
    *returnSize = size1 + size2;

    int i = 0, j = 0, k = 0;
    while (i < size1 && j < size2) {
        if (arr1[i] < arr2[j]) {
            result[k++] = arr1[i++];
        } else {
            result[k++] = arr2[j++];
        }
    }

    while (i < size1) {
        result[k++] = arr1[i++];
    }

    while (j < size2) {
        result[k++] = arr2[j++];
    }

    free(arr1);
    free(arr2);

    return result;
}