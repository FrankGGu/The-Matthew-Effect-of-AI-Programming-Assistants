#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits<long long>::max()

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
    long long min1_val;
    long long min2_val;

    void dfs(TreeNode* node) {
        if (node == nullptr) {
            return;
        }

        if (node->val > min1_val) {
            min2_val = std::min(min2_val, (long long)node->val);
            return; 
        }

        dfs(node->left);
        dfs(node->right);
    }

    int findSecondMinimumValue(TreeNode* root) {
        min1_val = root->val;
        min2_val = std::numeric_limits<long long>::max();

        dfs(root);

        if (min2_val == std::numeric_limits<long long>::max()) {
            return -1;
        } else {
            return static_cast<int>(min2_val);
        }
    }
};