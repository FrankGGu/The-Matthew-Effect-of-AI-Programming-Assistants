class Solution {
public:
    int cameras = 0;

    int minCameraCover(TreeNode* root) {
        if (dfs(root) == 0) {
            cameras++;
        }
        return cameras;
    }

    int dfs(TreeNode* node) {
        if (!node) {
            return 1;
        }

        int left = dfs(node->left);
        int right = dfs(node->right);

        if (left == 0 || right == 0) {
            cameras++;
            return 2;
        }

        if (left == 1 && right == 1) {
            return 0;
        }

        return 1;
    }
};