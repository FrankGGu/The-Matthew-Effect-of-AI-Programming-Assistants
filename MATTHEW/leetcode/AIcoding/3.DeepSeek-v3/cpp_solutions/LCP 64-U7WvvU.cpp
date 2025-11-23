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
    int ans;
    int minCameraCover(TreeNode* root) {
        ans = 0;
        if (dfs(root) == 0) {
            ans++;
        }
        return ans;
    }

    int dfs(TreeNode* node) {
        if (node == nullptr) {
            return 2;
        }
        int left = dfs(node->left);
        int right = dfs(node->right);
        if (left == 0 || right == 0) {
            ans++;
            return 1;
        }
        if (left == 1 || right == 1) {
            return 2;
        }
        return 0;
    }
};