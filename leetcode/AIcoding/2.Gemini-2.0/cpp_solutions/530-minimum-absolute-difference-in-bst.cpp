class Solution {
public:
    int getMinimumDifference(TreeNode* root) {
        int minDiff = INT_MAX;
        TreeNode* prev = nullptr;

        function<void(TreeNode*)> inorder = [&](TreeNode* node) {
            if (!node) return;

            inorder(node->left);

            if (prev) {
                minDiff = min(minDiff, abs(node->val - prev->val));
            }

            prev = node;

            inorder(node->right);
        };

        inorder(root);

        return minDiff;
    }
};