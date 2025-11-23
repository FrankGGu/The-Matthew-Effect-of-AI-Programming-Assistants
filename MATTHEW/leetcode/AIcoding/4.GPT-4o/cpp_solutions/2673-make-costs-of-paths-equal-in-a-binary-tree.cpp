class Solution {
public:
    int minCost(TreeNode* root) {
        if (!root) return 0;

        int leftCost = minCost(root->left);
        int rightCost = minCost(root->right);

        if (root->left && root->right) {
            return leftCost + rightCost + abs(root->left->val - root->right->val);
        }

        return leftCost + rightCost;
    }
};