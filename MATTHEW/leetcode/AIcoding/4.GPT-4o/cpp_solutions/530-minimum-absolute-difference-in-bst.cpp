class Solution {
public:
    int getMinimumDifference(TreeNode* root) {
        vector<int> values;
        inorderTraversal(root, values);
        int minDiff = INT_MAX;
        for (int i = 1; i < values.size(); i++) {
            minDiff = min(minDiff, values[i] - values[i - 1]);
        }
        return minDiff;
    }

    void inorderTraversal(TreeNode* node, vector<int>& values) {
        if (!node) return;
        inorderTraversal(node->left, values);
        values.push_back(node->val);
        inorderTraversal(node->right, values);
    }
};