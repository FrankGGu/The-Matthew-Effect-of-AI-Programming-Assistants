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
    bool isSubStructure(TreeNode* A, TreeNode* B) {
        if (B == nullptr || A == nullptr) return false;
        return dfs(A, B) || isSubStructure(A->left, B) || isSubStructure(A->right, B);
    }

private:
    bool dfs(TreeNode* A, TreeNode* B) {
        if (B == nullptr) return true;
        if (A == nullptr) return false;
        return A->val == B->val && dfs(A->left, B->left) && dfs(A->right, B->right);
    }
};