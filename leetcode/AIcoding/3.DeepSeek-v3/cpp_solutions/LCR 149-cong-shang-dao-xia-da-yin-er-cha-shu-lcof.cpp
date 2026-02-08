#include <vector>
#include <queue>
#include <algorithm>
using namespace std;

class Solution {
public:
    vector<vector<int>> decorateRecord(TreeNode* root) {
        vector<vector<int>> result;
        if (!root) return result;

        queue<TreeNode*> q;
        q.push(root);
        int level = 0;

        while (!q.empty()) {
            int size = q.size();
            vector<int> currentLevel;

            for (int i = 0; i < size; i++) {
                TreeNode* node = q.front();
                q.pop();
                currentLevel.push_back(node->val);
                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }

            if (level % 2 == 1) {
                reverse(currentLevel.begin(), currentLevel.end());
            }

            result.push_back(currentLevel);
            level++;
        }

        return result;
    }
};