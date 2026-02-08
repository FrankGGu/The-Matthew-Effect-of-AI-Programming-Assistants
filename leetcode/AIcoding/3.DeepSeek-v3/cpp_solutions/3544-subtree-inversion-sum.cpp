class Solution {
public:
    int sum = 0;

    TreeNode* invertTree(TreeNode* root) {
        if (!root) return nullptr;
        TreeNode* left = invertTree(root->left);
        TreeNode* right = invertTree(root->right);
        root->left = right;
        root->right = left;
        return root;
    }

    void dfs(TreeNode* root) {
        if (!root) return;
        sum += root->val;
        dfs(root->left);
        dfs(root->right);
    }

    int subtreeInversionSum(TreeNode* root) {
        if (!root) return 0;
        int res = 0;
        queue<TreeNode*> q;
        q.push(root);
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            TreeNode* inverted = invertTree(node);
            sum = 0;
            dfs(inverted);
            res += sum;
            invertTree(node);
            if (node->left) q.push(node->left);
            if (node->right) q.push(node->right);
        }
        return res;
    }
};