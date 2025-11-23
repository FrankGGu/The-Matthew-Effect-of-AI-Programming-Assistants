#include <iostream>
#include <string>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    string tree2str(TreeNode* root) {
        if (!root) return "";
        string result = to_string(root->val);
        if (root->left || root->right) {
            result += "(" + tree2str(root->left) + ")";
            if (root->right) {
                result += "(" + tree2str(root->right) + ")";
            }
        }
        return result;
    }
};