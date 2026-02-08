#include <vector>
#include <queue>
#include <algorithm>

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
    std::vector<std::vector<int>> zigzagLevelOrder(TreeNode* root) {
        std::vector<std::vector<int>> result;
        if (!root) {
            return result;
        }

        std::queue<TreeNode*> q;
        q.push(root);
        int level = 0;

        while (!q.empty()) {
            int level_size = q.size();
            std::vector<int> current_level_nodes;
            for (int i = 0; i < level_size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                current_level_nodes.push_back(node->val);

                if (node->left) {
                    q.push(node->left);
                }
                if (node->right) {
                    q.push(node->right);
                }
            }

            if (level % 2 == 1) {
                std::reverse(current_level_nodes.begin(), current_level_nodes.end());
            }
            result.push_back(current_level_nodes);
            level++;
        }
        return result;
    }
};