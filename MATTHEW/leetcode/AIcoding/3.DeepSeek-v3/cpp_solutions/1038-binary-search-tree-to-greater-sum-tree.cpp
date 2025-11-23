class Solution {
public:
    TreeNode* bstToGst(TreeNode* root) {
        int sum = 0;
        traverse(root, sum);
        return root;
    }

private:
    void traverse(TreeNode* node, int& sum) {
        if (!node) return;
        traverse(node->right, sum);
        sum += node->val;
        node->val = sum;
        traverse(node->left, sum);
    }
};