struct TreeNode* constructMaximumBinaryTree(int* nums, int numsSize) {
    if (numsSize == 0) return NULL;

    int maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[maxIndex]) {
            maxIndex = i;
        }
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = nums[maxIndex];
    root->left = constructMaximumBinaryTree(nums, maxIndex);
    root->right = constructMaximumBinaryTree(nums + maxIndex + 1, numsSize - maxIndex - 1);

    return root;
}