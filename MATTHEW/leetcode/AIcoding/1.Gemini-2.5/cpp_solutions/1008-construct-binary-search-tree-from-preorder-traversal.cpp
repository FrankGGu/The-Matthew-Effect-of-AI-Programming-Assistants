#include <vector>
#include <limits>

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
    TreeNode* bstFromPreorder(std::vector<int>& preorder) {
        int idx = 0;
        return build(preorder, idx, std::numeric_limits<int>::min(), std::numeric_limits<int>::max());
    }

private:
    TreeNode* build(const std::vector<int>& preorder, int& idx, int lower_bound, int upper_bound) {
        if (idx == preorder.size() || preorder[idx] < lower_bound || preorder[idx] > upper_bound) {
            return nullptr;
        }

        TreeNode* root = new TreeNode(preorder[idx]);
        idx++;

        root->left = build(preorder, idx, lower_bound, root->val);
        root->right = build(preorder, idx, root->val, upper_bound);

        return root;
    }
};