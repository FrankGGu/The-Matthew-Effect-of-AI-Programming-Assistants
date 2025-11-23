class Solution {
public:
    int minCameraCover(TreeNode* root) {
        int cameras = 0;
        if (dfs(root, cameras) == 0) {
            cameras++;
        }
        return cameras;
    }

private:
    int dfs(TreeNode* node, int& cameras) {
        if (!node) return 2;
        int left = dfs(node->left, cameras);
        int right = dfs(node->right, cameras);

        if (left == 0 || right == 0) {
            cameras++;
            return 1;
        }
        return (left == 1 || right == 1) ? 2 : 0;
    }
};