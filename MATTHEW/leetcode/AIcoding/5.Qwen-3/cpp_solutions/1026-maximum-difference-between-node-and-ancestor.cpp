#include <iostream>
#include <vector>
#include <climits>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    int maxAncestorDiff(TreeNode* root) {
        return dfs(root, root->val, root->val);
    }

private:
    int dfs(TreeNode* node, int minVal, int maxVal) {
        if (!node) {
            return maxVal - minVal;
        }
        int currentMax = max(maxVal, node->val);
        int currentMin = min(minVal, node->val);
        int left = dfs(node->left, currentMin, currentMax);
        int right = dfs(node->right, currentMin, currentMax);
        return max(left, right);
    }
};