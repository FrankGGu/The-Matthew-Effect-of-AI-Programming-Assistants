class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    bool isCousins(TreeNode* root, int x, int y) {
        if (!root) return false;
        int xDepth = -1, yDepth = -1;
        TreeNode* xParent = nullptr;
        TreeNode* yParent = nullptr;
        dfs(root, nullptr, 0, x, y, xDepth, yDepth, xParent, yParent);
        return (xDepth == yDepth) && (xParent != yParent);
    }

    void dfs(TreeNode* node, TreeNode* parent, int depth, int x, int y, int& xDepth, int& yDepth, TreeNode*& xParent, TreeNode*& yParent) {
        if (!node) return;
        if (node->val == x) {
            xDepth = depth;
            xParent = parent;
        } else if (node->val == y) {
            yDepth = depth;
            yParent = parent;
        }
        dfs(node->left, node, depth + 1, x, y, xDepth, yDepth, xParent, yParent);
        dfs(node->right, node, depth + 1, x, y, xDepth, yDepth, xParent, yParent);
    }
};