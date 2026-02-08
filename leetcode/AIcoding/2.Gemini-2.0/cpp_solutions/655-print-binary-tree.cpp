#include <vector>
#include <queue>
#include <cmath>

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
    vector<vector<string>> printTree(TreeNode* root) {
        int height = getHeight(root);
        int width = pow(2, height) - 1;
        vector<vector<string>> result(height, vector<string>(width, ""));
        fillTree(root, result, 0, 0, width - 1);
        return result;
    }

private:
    int getHeight(TreeNode* root) {
        if (!root) return 0;
        return 1 + max(getHeight(root->left), getHeight(root->right));
    }

    void fillTree(TreeNode* root, vector<vector<string>>& result, int row, int left, int right) {
        if (!root) return;
        int mid = (left + right) / 2;
        result[row][mid] = to_string(root->val);
        fillTree(root->left, result, row + 1, left, mid - 1);
        fillTree(root->right, result, row + 1, mid + 1, right);
    }
};