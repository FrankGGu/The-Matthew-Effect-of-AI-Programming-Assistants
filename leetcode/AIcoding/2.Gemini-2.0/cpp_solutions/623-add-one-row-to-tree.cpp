class Solution {
public:
    TreeNode* addOneRow(TreeNode* root, int val, int depth) {
        if (depth == 1) {
            TreeNode* newRoot = new TreeNode(val);
            newRoot->left = root;
            return newRoot;
        }

        function<void(TreeNode*, int)> dfs = [&](TreeNode* node, int currentDepth) {
            if (!node) return;

            if (currentDepth == depth - 1) {
                TreeNode* left = node->left;
                TreeNode* right = node->right;

                node->left = new TreeNode(val);
                node->right = new TreeNode(val);

                node->left->left = left;
                node->right->right = right;
                return;
            }

            dfs(node->left, currentDepth + 1);
            dfs(node->right, currentDepth + 1);
        };

        dfs(root, 1);
        return root;
    }
};