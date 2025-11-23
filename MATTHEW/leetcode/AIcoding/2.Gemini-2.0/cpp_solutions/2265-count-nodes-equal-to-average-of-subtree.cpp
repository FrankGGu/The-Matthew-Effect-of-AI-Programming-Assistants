class Solution {
public:
    int count = 0;

    pair<int, int> dfs(TreeNode* root) {
        if (!root) {
            return {0, 0};
        }

        pair<int, int> left = dfs(root->left);
        pair<int, int> right = dfs(root->right);

        int sum = root->val + left.first + right.first;
        int numNodes = 1 + left.second + right.second;

        if (root->val == sum / numNodes) {
            count++;
        }

        return {sum, numNodes};
    }

    int averageOfSubtree(TreeNode* root) {
        dfs(root);
        return count;
    }
};