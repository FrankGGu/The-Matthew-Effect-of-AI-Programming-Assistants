class Solution {
public:
    int pathSum(TreeNode* root, int sum) {
        if (!root) return 0;
        return countPaths(root, sum) + pathSum(root->left, sum) + pathSum(root->right, sum);
    }

    int countPaths(TreeNode* node, int sum) {
        if (!node) return 0;
        return (node->val == sum ? 1 : 0) + countPaths(node->left, sum - node->val) + countPaths(node->right, sum - node->val);
    }
};