#include <iostream>
#include <vector>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    vector<int> searchBST(TreeNode* root, int val) {
        vector<int> result;
        TreeNode* current = root;
        while (current != nullptr) {
            if (current->val == val) {
                result.push_back(current->val);
                current = current->left;
            } else if (current->val < val) {
                current = current->right;
            } else {
                current = current->left;
            }
        }
        return result;
    }
};