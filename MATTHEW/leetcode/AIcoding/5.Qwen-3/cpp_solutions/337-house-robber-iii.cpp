#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    int rob(TreeNode* root) {
        return dfs(root).first;
    }

private:
    pair<int, int> dfs(TreeNode* node) {
        if (!node) {
            return {0, 0};
        }

        auto left = dfs(node->left);
        auto right = dfs(node->right);

        int select = node->val + left.second + right.second;
        int not_select = max(left.first, left.second) + max(right.first, right.second);

        return {select, not_select};
    }
};