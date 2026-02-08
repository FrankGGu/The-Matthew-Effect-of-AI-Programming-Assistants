#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> postorderTraversal(TreeNode* root) {
        vector<int> result;
        stack<TreeNode*> s;
        TreeNode* prev = nullptr;
        while (root || !s.empty()) {
            while (root) {
                s.push(root);
                root = root->left;
            }
            root = s.top();
            if (root->right && root->right != prev) {
                root = root->right;
            } else {
                result.push_back(root->val);
                prev = root;
                s.pop();
                root = nullptr;
            }
        }
        return result;
    }
};