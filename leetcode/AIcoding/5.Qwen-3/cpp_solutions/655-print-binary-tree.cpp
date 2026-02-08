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
    vector<vector<string>> printTree(TreeNode* root) {
        int height = getHeight(root);
        int width = pow(2, height) - 1;
        vector<vector<string>> result(height, vector<string>(width, ""));

        fillTree(result, root, 0, 0, width - 1);
        return result;
    }

private:
    int getHeight(TreeNode* node) {
        if (!node) return 0;
        return 1 + max(getHeight(node->left), getHeight(node->right));
    }

    void fillTree(vector<vector<string>>& result, TreeNode* node, int level, int left, int right) {
        if (!node) return;
        int mid = (left + right) / 2;
        result[level][mid] = to_string(node->val);
        fillTree(result, node->left, level + 1, left, mid - 1);
        fillTree(result, node->right, level + 1, mid + 1, right);
    }
};