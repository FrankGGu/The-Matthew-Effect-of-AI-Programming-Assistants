class Solution {
public:
    int kthSmallest(TreeNode* root, int k) {
        int count = 0;
        int result = -1;

        function<void(TreeNode*)> inorder = [&](TreeNode* node) {
            if (!node) return;

            inorder(node->left);
            count++;
            if (count == k) {
                result = node->val;
                return;
            }
            inorder(node->right);
        };

        inorder(root);
        return result;
    }
};