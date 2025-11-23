#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int minimumOperations(TreeNode* root) {
        if (!root) return 0;

        int operations = 0;
        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            int n = q.size();
            vector<int> level;
            for (int i = 0; i < n; ++i) {
                TreeNode* node = q.front();
                q.pop();
                level.push_back(node->val);
                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }
            vector<int> sorted_level = level;
            sort(sorted_level.begin(), sorted_level.end());
            int count = 0;
            vector<bool> visited(n, false);
            for (int i = 0; i < n; ++i) {
                if (visited[i] || level[i] == sorted_level[i]) continue;
                int cycle_size = 0;
                int j = i;
                while (!visited[j]) {
                    visited[j] = true;
                    j = find(level.begin(), level.end(), sorted_level[j]) - level.begin();
                    cycle_size++;
                }
                if (cycle_size > 0) count += (cycle_size - 1);
            }
            operations += count;
        }

        return operations;
    }
};