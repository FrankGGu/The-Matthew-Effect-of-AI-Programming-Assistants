class Solution {
public:
    int minCameraCover(TreeNode* root) {
        int res = 0;
        int status = dfs(root, res);
        if (status == 0) res++;
        return res;
    }

    int dfs(TreeNode* node, int& res) {
        if (!node) return 2;
        int left = dfs(node->left, res);
        int right = dfs(node->right, res);
        if (left == 0 || right == 0) {
            res++;
            return 1;
        }
        if (left == 1 || right == 1) {
            return 2;
        }
        return 0;
    }
};