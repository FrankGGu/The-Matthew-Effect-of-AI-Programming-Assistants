#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    int distributeCoins(TreeNode* root) {
        int result = 0;
        dfs(root, result);
        return result;
    }

private:
    int dfs(TreeNode* node, int& result) {
        if (!node) return 0;
        int left = dfs(node->left, result);
        int right = dfs(node->right, result);
        int total = left + right + node->val;
        result += abs(left) + abs(right);
        return total - 1;
    }
};