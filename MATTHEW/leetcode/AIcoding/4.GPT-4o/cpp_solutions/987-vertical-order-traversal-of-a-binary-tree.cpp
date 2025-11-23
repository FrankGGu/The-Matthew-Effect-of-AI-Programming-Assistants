#include <vector>
#include <map>
#include <queue>
#include <tuple>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<vector<int>> verticalOrder(TreeNode* root) {
        vector<vector<int>> result;
        if (!root) return result;

        map<int, map<int, vector<int>>> nodes;
        queue<pair<TreeNode*, pair<int, int>>> q; // pair<node, pair<vertical, level>>
        q.push({root, {0, 0}});

        while (!q.empty()) {
            auto [node, pos] = q.front();
            q.pop();
            int x = pos.first, y = pos.second;

            nodes[x][y].push_back(node->val);

            if (node->left) q.push({node->left, {x - 1, y + 1}});
            if (node->right) q.push({node->right, {x + 1, y + 1}});
        }

        for (auto& [_, levelMap] : nodes) {
            vector<int> col;
            for (auto& [_, values] : levelMap) {
                col.insert(col.end(), values.begin(), values.end());
            }
            result.push_back(col);
        }

        return result;
    }
};