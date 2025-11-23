#include <queue>
#include <vector>
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
    TreeNode* reverseOddLevels(TreeNode* root) {
        if (!root) {
            return nullptr;
        }

        std::queue<TreeNode*> q;
        q.push(root);
        int level = 0;

        while (!q.empty()) {
            int level_size = q.size();
            std::vector<TreeNode*> current_level_nodes;
            std::vector<int> current_level_values;

            for (int i = 0; i < level_size; ++i) {
                TreeNode* node = q.front();
                q.pop();

                current_level_nodes.push_back(node);
                current_level_values.push_back(node->val);

                if (node->left) { 
                    q.push(node->left);
                    q.push(node->right);
                }
            }

            if (level % 2 != 0) { 
                std::reverse(current_level_values.begin(), current_level_values.end());
                for (int i = 0; i < level_size; ++i) {
                    current_level_nodes[i]->val = current_level_values[i];
                }
            }
            level++;
        }
        return root;
    }
};