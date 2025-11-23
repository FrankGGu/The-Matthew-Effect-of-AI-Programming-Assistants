class Solution {
public:
    int widthOfBinaryTree(TreeNode* root) {
        if (!root) return 0;
        queue<pair<TreeNode*, unsigned long long>> q;
        q.push({root, 0});
        unsigned long long max_width = 0;

        while (!q.empty()) {
            unsigned long long left = q.front().second;
            unsigned long long right = left;
            int size = q.size();

            for (int i = 0; i < size; ++i) {
                auto node = q.front().first;
                right = q.front().second;
                q.pop();

                if (node->left) {
                    q.push({node->left, 2 * right});
                }
                if (node->right) {
                    q.push({node->right, 2 * right + 1});
                }
            }
            max_width = max(max_width, right - left + 1);
        }

        return max_width;
    }
};