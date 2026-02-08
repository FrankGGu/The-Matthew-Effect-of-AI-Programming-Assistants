#include <iostream>
#include <vector>
#include <climits>

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
    TreeNode* bstFromPreorder(vector<int>& preorder) {
        return build(preorder, 0, preorder.size() - 1);
    }

private:
    TreeNode* build(const vector<int>& preorder, int low, int high) {
        if (low > high) return nullptr;
        TreeNode* root = new TreeNode(preorder[low]);
        int i = low + 1;
        while (i <= high && preorder[i] < preorder[low]) ++i;
        root->left = build(preorder, low + 1, i - 1);
        root->right = build(preorder, i, high);
        return root;
    }
};