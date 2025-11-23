class Solution {
public:
    TreeNode* convertBST(TreeNode* root) {
        int sum = 0;
        reverseInorder(root, sum);
        return root;
    }

private:
    void reverseInorder(TreeNode* node, int& sum) {
        if (!node) return;
        reverseInorder(node->right, sum);
        sum += node->val;
        node->val = sum;
        reverseInorder(node->left, sum);
    }
};