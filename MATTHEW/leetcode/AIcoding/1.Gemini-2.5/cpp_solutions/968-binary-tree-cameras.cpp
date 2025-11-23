class Solution {
public:
    int cameras = 0;

    // States:
    // 0: Node needs to be monitored (not covered by children, doesn't have camera)
    // 1: Node has a camera
    // 2: Node is monitored (covered by children, doesn't have camera)
    int dfs(TreeNode* node) {
        if (node == nullptr) {
            return 2;
        }

        int left_state = dfs(node->left);
        int right_state = dfs(node->right);

        if (left_state == 0 || right_state == 0) {
            cameras++;
            return 1;
        }

        if (left_state == 1 || right_state == 1) {
            return 2;
        }

        return 0;
    }

    int minCameraCover(TreeNode* root) {
        if (dfs(root) == 0) {
            cameras++;
        }
        return cameras;
    }
};