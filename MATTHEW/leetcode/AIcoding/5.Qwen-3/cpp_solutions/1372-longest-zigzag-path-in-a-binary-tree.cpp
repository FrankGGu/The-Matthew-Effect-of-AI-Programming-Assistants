#include <iostream>
#include <vector>
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
    int longestZigZag(TreeNode* root) {
        int result = 0;
        dfs(root, false, 0, result);
        return result;
    }

private:
    void dfs(TreeNode* node, bool isLeft, int count, int& result) {
        if (!node) return;
        result = max(result, count);
        if (isLeft) {
            dfs(node->left, false, 1, result);
            dfs(node->right, true, count + 1, result);
        } else {
            dfs(node->left, true, count + 1, result);
            dfs(node->right, false, 1, result);
        }
    }
};