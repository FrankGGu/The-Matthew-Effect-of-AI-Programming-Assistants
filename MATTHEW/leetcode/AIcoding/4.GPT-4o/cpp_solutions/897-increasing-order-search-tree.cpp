class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    TreeNode* increasingBST(TreeNode* root) {
        TreeNode dummy(0);
        TreeNode* curr = &dummy;
        inorder(root, curr);
        return dummy.right;
    }

    void inorder(TreeNode* node, TreeNode*& curr) {
        if (!node) return;
        inorder(node->left, curr);
        node->left = nullptr;
        curr->right = node;
        curr = curr->right;
        inorder(node->right, curr);
    }
};