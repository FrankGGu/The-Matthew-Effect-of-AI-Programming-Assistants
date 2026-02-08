#include <vector>
#include <queue>
#include <climits>
using namespace std;

class Solution {
public:
    vector<int> largestValues(TreeNode* root) {
        vector<int> result;
        if (!root) return result;

        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            int level_size = q.size();
            int max_val = INT_MIN;

            for (int i = 0; i < level_size; ++i) {
                TreeNode* node = q.front();
                q.pop();

                if (node->val > max_val) {
                    max_val = node->val;
                }

                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }

            result.push_back(max_val);
        }

        return result;
    }
};