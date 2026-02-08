class Solution {
public:
    pair<int, int> robSub(TreeNode* root) {
        if (!root) return {0, 0};

        pair<int, int> left = robSub(root->left);
        pair<int, int> right = robSub(root->right);

        int rob_root = root->val + left.second + right.second;
        int not_rob_root = max(left.first, left.second) + max(right.first, right.second);

        return {rob_root, not_rob_root};
    }

    int rob(TreeNode* root) {
        pair<int, int> result = robSub(root);
        return max(result.first, result.second);
    }
};