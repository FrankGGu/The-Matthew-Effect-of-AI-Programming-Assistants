#include <algorithm>
#include <vector>

using namespace std;

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
        vector<vector<int>> levels;
        queue<TreeNode*> q;
        q.push(root);
        int level = 0;

        while (!q.empty()) {
            int size = q.size();
            vector<int> currentLevel;
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                currentLevel.push_back(node->val);

                if (node->left) {
                    q.push(node->left);
                }
                if (node->right) {
                    q.push(node->right);
                }
            }
            levels.push_back(currentLevel);
            level++;
        }

        queue<TreeNode*> q2;
        q2.push(root);
        level = 0;

        while (!q2.empty()) {
            int size = q2.size();
            vector<TreeNode*> currentLevelNodes;
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q2.front();
                q2.pop();
                currentLevelNodes.push_back(node);

                if (node->left) {
                    q2.push(node->left);
                }
                if (node->right) {
                    q2.push(node->right);
                }
            }

            if (level % 2 != 0) {
                reverse(levels[level].begin(), levels[level].end());
                for (int i = 0; i < currentLevelNodes.size(); ++i) {
                    currentLevelNodes[i]->val = levels[level][i];
                }
            }

            level++;
        }

        return root;
    }
};