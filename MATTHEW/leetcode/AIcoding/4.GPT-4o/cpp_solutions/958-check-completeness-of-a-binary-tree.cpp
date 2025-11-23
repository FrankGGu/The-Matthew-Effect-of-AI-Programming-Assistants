class Solution {
public:
    bool isCompleteBinaryTree(TreeNode* root) {
        if (!root) return true;

        queue<TreeNode*> q;
        q.push(root);
        bool end = false;

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();

            if (node) {
                if (end) return false;
                q.push(node->left);
                q.push(node->right);
            } else {
                end = true;
            }
        }
        return true;
    }
};