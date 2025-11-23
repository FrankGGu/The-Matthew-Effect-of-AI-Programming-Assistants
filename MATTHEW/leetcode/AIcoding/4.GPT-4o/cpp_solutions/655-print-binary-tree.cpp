#include <vector>
#include <string>
#include <queue>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<vector<string>> printTree(TreeNode* root) {
        if (!root) return {};
        int height = getHeight(root);
        int width = (1 << height) - 1;
        vector<vector<string>> res(height, vector<string>(width, ""));
        fill(res, root, 0, 0, width - 1);
        return res;
    }

private:
    int getHeight(TreeNode* node) {
        if (!node) return 0;
        return 1 + max(getHeight(node->left), getHeight(node->right));
    }

    void fill(vector<vector<string>>& res, TreeNode* node, int row, int left, int right) {
        if (!node) return;
        int mid = left + (right - left) / 2;
        res[row][mid] = to_string(node->val);
        fill(res, node->left, row + 1, left, mid - 1);
        fill(res, node->right, row + 1, mid + 1, right);
    }
};