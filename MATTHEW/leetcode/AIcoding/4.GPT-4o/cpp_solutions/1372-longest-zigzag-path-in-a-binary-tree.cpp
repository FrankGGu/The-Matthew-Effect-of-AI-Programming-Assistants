class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int longestZigZag(TreeNode* root) {
        int maxLength = 0;
        dfs(root, 0, true, maxLength);
        dfs(root, 0, false, maxLength);
        return maxLength;
    }

    void dfs(TreeNode* node, int length, bool isLeft, int& maxLength) {
        if (!node) return;
        maxLength = max(maxLength, length);
        if (isLeft) {
            dfs(node->left, length + 1, false, maxLength);
            dfs(node->right, 1, true, maxLength);
        } else {
            dfs(node->right, length + 1, true, maxLength);
            dfs(node->left, 1, false, maxLength);
        }
    }
};