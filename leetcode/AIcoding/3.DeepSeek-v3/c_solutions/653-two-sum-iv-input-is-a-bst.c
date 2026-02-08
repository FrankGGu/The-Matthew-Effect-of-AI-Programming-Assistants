typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

bool findTargetHelper(struct TreeNode* root, int k, int* nums, int* size) {
    if (root == NULL) return false;

    if (findTargetHelper(root->left, k, nums, size)) return true;

    for (int i = 0; i < *size; i++) {
        if (nums[i] + root->val == k) return true;
    }
    nums[(*size)++] = root->val;

    return findTargetHelper(root->right, k, nums, size);
}

bool findTarget(struct TreeNode* root, int k) {
    int nums[10000];
    int size = 0;
    return findTargetHelper(root, k, nums, &size);
}