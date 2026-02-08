#include <queue> // Required for std::queue

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int deepestLeavesSum(TreeNode* root) {
        if (root == nullptr) {
            return 0;
        }

        std::queue<TreeNode*> q;
        q.push(root);
        int deepest_sum = 0;

        while (!q.empty()) {
            int level_size = q.size();
            int current_level_sum = 0;

            for (int i = 0; i < level_size; ++i) {
                TreeNode* node = q.front();
                q.pop();

                current_level_sum += node->val;

                if (node->left) {
                    q.push(node->left);
                }
                if (node->right) {
                    q.push(node->right);
                }
            }
            // After processing all nodes at the current level,
            // update deepest_sum. The last level processed will contain the deepest leaves.
            deepest_sum = current_level_sum;
        }
        return deepest_sum;
    }
};