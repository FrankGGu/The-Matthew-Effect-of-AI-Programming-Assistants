#include <vector>
#include <queue>
#include <algorithm>
#include <functional>

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
    long long kthLargestLevelSum(TreeNode* root, int k) {
        std::vector<long long> level_sums;
        std::queue<TreeNode*> q;

        if (root) {
            q.push(root);
        }

        while (!q.empty()) {
            int level_size = q.size();
            long long current_level_sum = 0;

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
            level_sums.push_back(current_level_sum);
        }

        std::sort(level_sums.begin(), level_sums.end(), std::greater<long long>());

        return level_sums[k - 1];
    }
};