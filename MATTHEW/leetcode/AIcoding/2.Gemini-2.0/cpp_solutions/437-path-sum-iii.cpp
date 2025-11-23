class Solution {
public:
    int pathSum(TreeNode* root, int targetSum) {
        if (!root) return 0;
        return pathSumFrom(root, targetSum) + pathSum(root->left, targetSum) + pathSum(root->right, targetSum);
    }

private:
    int pathSumFrom(TreeNode* node, long long targetSum) {
        if (!node) return 0;
        int count = 0;
        if (node->val == targetSum) count++;
        count += pathSumFrom(node->left, targetSum - node->val);
        count += pathSumFrom(node->right, targetSum - node->val);
        return count;
    }
};