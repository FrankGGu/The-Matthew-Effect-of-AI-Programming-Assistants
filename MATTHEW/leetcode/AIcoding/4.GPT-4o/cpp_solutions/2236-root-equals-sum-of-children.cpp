class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    bool checkTree(TreeNode* root) {
        return root->val == (root->left ? root->left->val : 0) + (root->right ? root->right->val : 0);
    }
};