#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    int minCameraCover(TreeNode* root) {
        int camera = 0;
        function<int(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return 1;
            int left = dfs(node->left);
            int right = dfs(node->right);
            if (left == 0 || right == 0) {
                ++camera;
                return 2;
            }
            if (left == 2 || right == 2) {
                return 1;
            }
            return 0;
        };
        return dfs(root) == 0 ? camera + 1 : camera;
    }
};