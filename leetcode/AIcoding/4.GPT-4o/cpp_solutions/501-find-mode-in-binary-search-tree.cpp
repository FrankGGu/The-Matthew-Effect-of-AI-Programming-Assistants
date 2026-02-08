#include <vector>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<int> findMode(TreeNode* root) {
        vector<int> modes;
        int maxCount = 0, currentCount = 0, currentVal = 0;
        inorder(root, modes, maxCount, currentCount, currentVal);
        return modes;
    }

private:
    void inorder(TreeNode* node, vector<int>& modes, int& maxCount, int& currentCount, int& currentVal) {
        if (!node) return;
        inorder(node->left, modes, maxCount, currentCount, currentVal);
        if (node->val == currentVal) {
            currentCount++;
        } else {
            currentVal = node->val;
            currentCount = 1;
        }
        if (currentCount > maxCount) {
            maxCount = currentCount;
            modes = {currentVal};
        } else if (currentCount == maxCount) {
            modes.push_back(currentVal);
        }
        inorder(node->right, modes, maxCount, currentCount, currentVal);
    }
};