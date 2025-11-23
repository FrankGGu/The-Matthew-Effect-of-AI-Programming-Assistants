#include <iostream>
#include <vector>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    int kthSmallest(TreeNode* root, int k) {
        vector<int> result;
        inorderTraversal(root, result);
        return result[k-1];
    }

private:
    void inorderTraversal(TreeNode* node, vector<int>& result) {
        if (node == nullptr) {
            return;
        }
        inorderTraversal(node->left, result);
        result.push_back(node->val);
        inorderTraversal(node->right, result);
    }
};