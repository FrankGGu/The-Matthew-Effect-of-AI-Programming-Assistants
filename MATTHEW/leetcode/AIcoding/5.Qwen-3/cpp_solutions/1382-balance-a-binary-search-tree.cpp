#include <iostream>
#include <vector>

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
    TreeNode* balanceBST(TreeNode* root) {
        vector<int> sorted;
        inorderTraversal(root, sorted);
        return buildBalancedBST(sorted, 0, sorted.size() - 1);
    }

private:
    void inorderTraversal(TreeNode* node, vector<int>& sorted) {
        if (!node) return;
        inorderTraversal(node->left, sorted);
        sorted.push_back(node->val);
        inorderTraversal(node->right, sorted);
    }

    TreeNode* buildBalancedBST(vector<int>& sorted, int left, int right) {
        if (left > right) return nullptr;
        int mid = left + (right - left) / 2;
        TreeNode* node = new TreeNode(sorted[mid]);
        node->left = buildBalancedBST(sorted, left, mid - 1);
        node->right = buildBalancedBST(sorted, mid + 1, right);
        return node;
    }
};