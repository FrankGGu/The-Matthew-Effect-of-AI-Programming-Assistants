class Solution {
public:
    int findBottomLeftValue(TreeNode* root) {
        if (!root) return 0;
        queue<TreeNode*> q;
        q.push(root);
        int bottomLeftValue = root->val;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                if (i == 0) bottomLeftValue = node->val;
                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }
        }

        return bottomLeftValue;
    }
};