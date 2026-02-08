#include <vector>
#include <queue>
#include <algorithm> // For std::reverse

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
    std::vector<std::vector<int>> decorateRecord(TreeNode* root) {
        std::vector<std::vector<int>> result;
        if (!root) {
            return result;
        }

        std::queue<TreeNode*> q;
        q.push(root);
        bool leftToRight = true; // Flag to determine current level's traversal direction

        while (!q.empty()) {
            int levelSize = q.size();
            std::vector<int> currentLevelNodes;
            currentLevelNodes.reserve(levelSize);

            for (int i = 0; i < levelSize; ++i) {
                TreeNode* node = q.front();
                q.pop();

                currentLevelNodes.push_back(node->val);

                if (node->left) {
                    q.push(node->left);
                }
                if (node->right) {
                    q.push(node->right);
                }
            }

            if (!leftToRight) {
                std::reverse(currentLevelNodes.begin(), currentLevelNodes.end());
            }

            result.push_back(currentLevelNodes);
            leftToRight = !leftToRight; // Toggle direction for the next level
        }

        return result;
    }
};