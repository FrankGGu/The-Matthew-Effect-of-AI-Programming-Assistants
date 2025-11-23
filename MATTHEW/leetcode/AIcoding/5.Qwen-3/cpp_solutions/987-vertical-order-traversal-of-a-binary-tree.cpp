#include <iostream>
#include <vector>
#include <map>
#include <queue>
#include <algorithm>

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
    vector<vector<int>> verticalOrder(TreeNode* root) {
        if (!root) return {};

        map<int, vector<int>> columnMap;
        queue<pair<TreeNode*, int>> q;
        q.push({root, 0});

        while (!q.empty()) {
            auto node = q.front();
            q.pop();
            TreeNode* current = node.first;
            int col = node.second;

            columnMap[col].push_back(current->val);

            if (current->left) {
                q.push({current->left, col - 1});
            }
            if (current->right) {
                q.push({current->right, col + 1});
            }
        }

        vector<vector<int>> result;
        for (auto& pair : columnMap) {
            result.push_back(pair.second);
        }

        return result;
    }
};