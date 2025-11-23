class Solution {
public:
    bool isValidBST(TreeNode* root) {
        return isValidBSTHelper(root, nullptr, nullptr);
    }

private:
    bool isValidBSTHelper(TreeNode* root, TreeNode* minNode, TreeNode* maxNode) {
        if (!root) return true;

        if (minNode && root->val <= minNode->val) return false;
        if (maxNode && root->val >= maxNode->val) return false;

        return isValidBSTHelper(root->left, minNode, root) && isValidBSTHelper(root->right, root, maxNode);
    }
};