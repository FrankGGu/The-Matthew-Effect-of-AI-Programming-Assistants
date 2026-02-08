class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int maxAncestorDiff(TreeNode* root) {
        return helper(root, root->val, root->val);
    }

    int helper(TreeNode* node, int minVal, int maxVal) {
        if (!node) return maxVal - minVal;
        minVal = min(minVal, node->val);
        maxVal = max(maxVal, node->val);
        return max(helper(node->left, minVal, maxVal), helper(node->right, minVal, maxVal));
    }
};