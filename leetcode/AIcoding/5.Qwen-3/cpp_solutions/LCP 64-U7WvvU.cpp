#include <iostream>
#include <vector>
#include <queue>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    vector<vector<int>> verticalTraversal(TreeNode* root) {
        vector<vector<int>> result;
        if (!root) return result;

        queue<pair<TreeNode*, int>> q;
        q.push({root, 0});

        vector<pair<int, int>> nodes;
        int minCol = 0, maxCol = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [node, col] = q.front();
                q.pop();

                nodes.push_back({col, node->val});

                if (node->left) {
                    q.push({node->left, col - 1});
                    minCol = min(minCol, col - 1);
                }
                if (node->right) {
                    q.push({node->right, col + 1});
                    maxCol = max(maxCol, col + 1);
                }
            }
        }

        result.resize(maxCol - minCol + 1);

        for (const auto& p : nodes) {
            result[p.first - minCol].push_back(p.second);
        }

        return result;
    }
};