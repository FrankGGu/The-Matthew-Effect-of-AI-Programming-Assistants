class Solution {
public:
    TreeNode* getTargetCopy(TreeNode* original, TreeNode* cloned, TreeNode* target) {
        if (!original) return nullptr;
        if (original == target) return cloned;

        TreeNode* left = getTargetCopy(original->left, cloned->left, target);
        if (left) return left;

        TreeNode* right = getTargetCopy(original->right, cloned->right, target);
        if (right) return right;

        return nullptr;
    }
};