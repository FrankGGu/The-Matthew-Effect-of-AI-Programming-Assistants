#include <unordered_map>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
private:
    unordered_map<TreeNode*, unordered_map<int, int>> memo;

    int dfs(TreeNode* node, int k) {
        if (!node) return 0;
        if (memo[node].count(k)) return memo[node][k];

        int not_take = dfs(node->left, k) + dfs(node->right, k);
        int take = 0;
        if (k > 0) {
            int left = dfs(node->left, k - 1);
            int right = dfs(node->right, k - 1);
            take = node->val + left + right;
        }
        memo[node][k] = max(not_take, take);
        return memo[node][k];
    }

public:
    int maxValue(TreeNode* root, int k) {
        return dfs(root, k);
    }
};