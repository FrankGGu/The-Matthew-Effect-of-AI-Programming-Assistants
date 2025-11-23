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
    int minimumTime(TreeNode* root) {
        return dfs(root).second;
    }

private:
    pair<int, int> dfs(TreeNode* node) {
        if (!node) {
            return {0, 0};
        }

        pair<int, int> left = dfs(node->left);
        pair<int, int> right = dfs(node->right);

        int max_time = max(left.first, right.first) + node->val;
        int ans = max(max(left.second, right.second), left.first + right.first + node->val);

        return {max_time, ans};
    }
};