#include <iostream>
#include <vector>
#include <climits>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int findSecondMinimumValue(TreeNode* root) {
        int result = INT_MAX;
        bool found = false;
        int minVal = root->val;
        traverse(root, minVal, result, found);
        return found ? result : -1;
    }

private:
    void traverse(TreeNode* node, int& minVal, int& result, bool& found) {
        if (node == NULL) return;
        if (node->val > minVal) {
            if (node->val < result) {
                result = node->val;
                found = true;
            }
        }
        traverse(node->left, minVal, result, found);
        traverse(node->right, minVal, result, found);
    }
};