class Solution {
private:
    int ans;

    void dfs(TreeNode* node, int path_counts) {
        if (!node) {
            return;
        }

        path_counts ^= (1 << node->val);

        if (!node->left && !node->right) {
            if ((path_counts & (path_counts - 1)) == 0) {
                ans++;
            }
            return;
        }

        dfs(node->left, path_counts);
        dfs(node->right, path_counts);
    }

public:
    int pseudoPalindromicPaths(TreeNode* root) {
        ans = 0;
        dfs(root, 0);
        return ans;
    }
};