class Solution {
private:
    int currentSum = 0;

    void reverseInorderTraversal(TreeNode* node) {
        if (!node) {
            return;
        }

        reverseInorderTraversal(node->right);

        currentSum += node->val;
        node->val = currentSum;

        reverseInorderTraversal(node->left);
    }

public:
    TreeNode* convertBST(TreeNode* root) {
        currentSum = 0;
        reverseInorderTraversal(root);
        return root;
    }
};