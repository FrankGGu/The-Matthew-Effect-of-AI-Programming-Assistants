class Solution {
public:
    TreeNode* balanceBST(TreeNode* root) {
        vector<int> inorder;
        inorderTraversal(root, inorder);
        return buildBalancedBST(inorder, 0, inorder.size() - 1);
    }

private:
    void inorderTraversal(TreeNode* root, vector<int>& inorder) {
        if (!root) return;
        inorderTraversal(root->left, inorder);
        inorder.push_back(root->val);
        inorderTraversal(root->right, inorder);
    }

    TreeNode* buildBalancedBST(const vector<int>& inorder, int start, int end) {
        if (start > end) return nullptr;
        int mid = start + (end - start) / 2;
        TreeNode* root = new TreeNode(inorder[mid]);
        root->left = buildBalancedBST(inorder, start, mid - 1);
        root->right = buildBalancedBST(inorder, mid + 1, end);
        return root;
    }
};