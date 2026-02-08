struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    TreeNode* increasingBST(TreeNode* root) {
        TreeNode* dummy = new TreeNode(0);
        TreeNode* cur = dummy;
        inorder(root, cur);
        return dummy->right;
    }

private:
    void inorder(TreeNode* root, TreeNode*& cur) {
        if (!root) return;

        inorder(root->left, cur);

        cur->right = new TreeNode(root->val);
        cur = cur->right;

        inorder(root->right, cur);

        root->left = nullptr;
        root->right = nullptr;
    }
};