#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    Solution() : recoveredSet() {}

    void recover(TreeNode* root) {
        if (root == nullptr) return;
        recoveredSet.insert(root->val);
        recover(root->left);
        recover(root->right);
    }

    bool find(TreeNode* root, int target) {
        recover(root);
        return recoveredSet.find(target) != recoveredSet.end();
    }

private:
    unordered_set<int> recoveredSet;
};