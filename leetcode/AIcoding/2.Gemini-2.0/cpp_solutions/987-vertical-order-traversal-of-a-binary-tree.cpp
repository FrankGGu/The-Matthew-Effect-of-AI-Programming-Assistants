#include <vector>
#include <queue>
#include <map>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

vector<vector<int>> verticalTraversal(TreeNode* root) {
    map<int, vector<pair<int, int>>> columnMap;
    queue<pair<TreeNode*, pair<int, int>>> q;

    if (root == nullptr) return {};

    q.push({root, {0, 0}});

    while (!q.empty()) {
        TreeNode* node = q.front().first;
        int column = q.front().second.first;
        int row = q.front().second.second;
        q.pop();

        columnMap[column].push_back({row, node->val});

        if (node->left) {
            q.push({node->left, {column - 1, row + 1}});
        }
        if (node->right) {
            q.push({node->right, {column + 1, row + 1}});
        }
    }

    vector<vector<int>> result;
    for (auto& [column, nodes] : columnMap) {
        sort(nodes.begin(), nodes.end());
        vector<int> columnValues;
        for (auto& node : nodes) {
            columnValues.push_back(node.second);
        }
        result.push_back(columnValues);
    }

    return result;
}